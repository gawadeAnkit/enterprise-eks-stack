terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Project   = "Enterprise-EKS-Stack"
      ManagedBy = "Terraform"
    }
  }
}

# ── ECR Repositories ───────────────────────────────────────────────
locals {
  ecr_repos = ["enterprise-webapp", "enterprise-proxy", "devops-dashboard"]
}

resource "aws_ecr_repository" "repos" {
  for_each             = toset(local.ecr_repos)
  name                 = each.key
  image_tag_mutability = "MUTABLE"
  force_delete         = true
  image_scanning_configuration { scan_on_push = true }
}

resource "aws_ecr_lifecycle_policy" "repos" {
  for_each   = aws_ecr_repository.repos
  repository = each.value.name
  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Keep last 10 images"
      selection    = { tagStatus = "any", countType = "imageCountMoreThan", countNumber = 10 }
      action       = { type = "expire" }
    }]
  })
}

# ── IAM: EKS Cluster Role ──────────────────────────────────────────
resource "aws_iam_role" "eks_cluster" {
  name = "enterprise-eks-cluster-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{ Action = "sts:AssumeRole", Effect = "Allow", Principal = { Service = "eks.amazonaws.com" } }]
  })
}
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster.name
}

# ── IAM: EKS Node Role ─────────────────────────────────────────────
resource "aws_iam_role" "eks_nodes" {
  name = "enterprise-eks-node-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{ Action = "sts:AssumeRole", Effect = "Allow", Principal = { Service = "ec2.amazonaws.com" } }]
  })
}
resource "aws_iam_role_policy_attachment" "worker_node" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_nodes.name
}
resource "aws_iam_role_policy_attachment" "cni" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_nodes.name
}
resource "aws_iam_role_policy_attachment" "ecr_ro" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_nodes.name
}

# ── EKS Cluster ────────────────────────────────────────────────────
resource "aws_eks_cluster" "main" {
  name     = "enterprise-eks-cluster"
  role_arn = aws_iam_role.eks_cluster.arn
  version  = "1.31"

  vpc_config {
    subnet_ids             = ["subnet-04d4cad19e559dc48", "subnet-0c4d8a56e925ccd26", "subnet-0e4d9e54a436644ad"]
    endpoint_public_access = true
  }
  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }
  depends_on = [aws_iam_role_policy_attachment.eks_cluster_policy]
}

# ── EKS Managed Node Group ─────────────────────────────────────────
resource "aws_eks_node_group" "workers" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "enterprise-workers"
  node_role_arn   = aws_iam_role.eks_nodes.arn
  subnet_ids      = ["subnet-04d4cad19e559dc48", "subnet-0c4d8a56e925ccd26", "subnet-0e4d9e54a436644ad"]
  instance_types  = ["t3.medium"]
  capacity_type   = "ON_DEMAND"

  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 1
  }
  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.worker_node,
    aws_iam_role_policy_attachment.cni,
    aws_iam_role_policy_attachment.ecr_ro
  ]
}

# ── Outputs ────────────────────────────────────────────────────────
output "ecr_urls" {
  value = { for k, v in aws_ecr_repository.repos : k => v.repository_url }
}
output "eks_cluster_name"     { value = aws_eks_cluster.main.name }
output "eks_cluster_endpoint" { value = aws_eks_cluster.main.endpoint }
output "kubeconfig_command"   { value = "aws eks update-kubeconfig --region us-east-1 --name ${aws_eks_cluster.main.name}" }
