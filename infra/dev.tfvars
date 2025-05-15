vpc_name         = "eks-vpc"
vpc_cidr         = "10.0.0.0/16"
azs              = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
public_subnets   = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

cluster_name     = "eks-cluster-globant"
cluster_version  = "1.32"

node_instance_types = ["t3.small"]
node_min            = 1
node_desired        = 2
node_max            = 3

jenkins_iam_role_name = "ec2-connect"


