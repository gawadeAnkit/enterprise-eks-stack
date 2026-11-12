variable "aws_region" {
  description = "AWS region for the EKS cluster and infrastructure"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Name of the Amazon EKS cluster"
  type        = string
  default     = "enterprise-eks-cluster"
}

variable "cluster_version" {
  description = "Kubernetes control plane version for EKS"
  type        = string
  default     = "1.31"
}

variable "subnet_ids" {
  description = "List of VPC Subnet IDs for EKS control plane and worker nodes"
  type        = list(string)
  default = [
    "subnet-04d4cad19e559dc48",
    "subnet-0c4d8a56e925ccd26",
    "subnet-0e4d9e54a436644ad"
  ]
}

variable "node_group_name" {
  description = "Name of the EKS managed node group"
  type        = string
  default     = "enterprise-workers"
}

variable "instance_types" {
  description = "EC2 instance types for EKS worker nodes"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "capacity_type" {
  description = "Capacity type for worker nodes (ON_DEMAND or SPOT)"
  type        = string
  default     = "ON_DEMAND"
}

variable "desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 4
}

variable "ecr_repos" {
  description = "List of Amazon ECR repository names for multi-tier container images"
  type        = list(string)
  default = [
    "enterprise-webapp",
    "enterprise-proxy",
    "devops-dashboard"
  ]
}

variable "cluster_role_name" {
  description = "IAM role name for the EKS cluster"
  type        = string
  default     = "enterprise-eks-cluster-role"
}

variable "node_role_name" {
  description = "IAM role name for EKS worker nodes"
  type        = string
  default     = "enterprise-eks-node-role"
}

variable "tags" {
  description = "Common tags applied to all infrastructure resources"
  type        = map(string)
  default = {
    Project   = "Enterprise-EKS-Stack"
    ManagedBy = "Terraform"
  }
}
