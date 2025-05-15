module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                   = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"           = "1"
  }

  tags = {
    Name = var.vpc_name
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  cluster_endpoint_public_access              = true
  enable_irsa                                 = true
  create_cloudwatch_log_group                 = true
  enable_cluster_creator_admin_permissions    = true
  authentication_mode                         = "API_AND_CONFIG_MAP"

  cluster_addons = {
    aws-ebs-csi-driver = {}
    aws-efs-csi-driver = {}
  }

  eks_managed_node_groups = {
    default = {
      instance_types = var.node_instance_types
      min_size       = var.node_min
      desired_size   = var.node_desired
      max_size       = var.node_max
    }
  }
}

resource "aws_eks_access_entry" "jenkins_role_entry" {
  cluster_name  = var.cluster_name
  principal_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.jenkins_iam_role_name}"
  depends_on    = [module.eks]
}

resource "aws_eks_access_policy_association" "jenkins_role_admin" {
  cluster_name  = var.cluster_name
  principal_arn = aws_eks_access_entry.jenkins_role_entry.principal_arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }

  depends_on = [aws_eks_access_entry.jenkins_role_entry]
}
