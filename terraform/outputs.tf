output "eks_cluster_name" {
  description = "Name of the provisioned Amazon EKS cluster"
  value       = aws_eks_cluster.main.name
}

output "eks_cluster_arn" {
  description = "ARN of the Amazon EKS cluster"
  value       = aws_eks_cluster.main.arn
}

output "eks_cluster_endpoint" {
  description = "Kubernetes API server endpoint URL"
  value       = aws_eks_cluster.main.endpoint
}

output "eks_cluster_version" {
  description = "Kubernetes control plane version"
  value       = aws_eks_cluster.main.version
}

output "eks_cluster_certificate_authority" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = aws_eks_cluster.main.certificate_authority[0].data
}

output "eks_node_group_arn" {
  description = "ARN of the EKS managed worker node group"
  value       = aws_eks_node_group.workers.arn
}

output "eks_node_role_arn" {
  description = "IAM Role ARN attached to EKS worker nodes"
  value       = aws_iam_role.eks_nodes.arn
}

output "ecr_urls" {
  description = "Map of ECR repository names to their repository URLs (legacy name)"
  value       = { for k, v in aws_ecr_repository.repos : k => v.repository_url }
}

output "ecr_repository_urls" {
  description = "Map of ECR repository names to their repository URLs"
  value       = { for k, v in aws_ecr_repository.repos : k => v.repository_url }
}

output "kubeconfig_command" {
  description = "AWS CLI command to configure local kubeconfig for the EKS cluster"
  value       = "aws eks update-kubeconfig --region ${var.aws_region} --name ${aws_eks_cluster.main.name}"
}
