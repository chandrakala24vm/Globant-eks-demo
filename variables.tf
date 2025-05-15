variable "region" {
  description = "AWS region"
  default     = "ap-south-1"
}

variable "cluster_name" {
  description = "EKS Cluster Name"
  default     = "eks-cluster-globant"
}


variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
}

variable "public_subnets" {
  description = "Public subnet CIDRs"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private subnet CIDRs"
  type        = list(string)
}

variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
}

variable "node_instance_types" {
  description = "Instance types for node group"
  type        = list(string)
}

variable "node_min" {
  description = "Minimum node count"
  type        = number
}

variable "node_desired" {
  description = "Desired node count"
  type        = number
}

variable "node_max" {
  description = "Maximum node count"
  type        = number
}

variable "jenkins_iam_role_name" {
  description = "IAM Role name to be granted EKS admin access (e.g., Jenkins role)"
  type        = string
}

variable "tags" {
  description = "tags"
  type        = map
  default = {
    name = "globant"
    env = "prod"
  }
}
