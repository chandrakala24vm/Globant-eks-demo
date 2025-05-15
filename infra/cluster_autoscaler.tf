resource "helm_release" "cluster_autoscaler" {
  name       = "cluster-autoscaler"
  namespace  = "kube-system"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  version    = "9.29.0"

  set {
    name  = "autoDiscovery.clusterName"
    value = var.cluster_name
  }

  set {
    name  = "awsRegion"
    value = var.region
  }

  set {
    name  = "rbac.create"
    value = "true"
  }

  set {
    name  = "cloudProvider"
    value = "aws"
  }

  set {
    name  = "serviceAccount.name"
    value = "cluster-autoscaler"
  }

  # set {
  #   name  = "serviceAccount.annotations[eks.amazonaws.com/role-arn]"
  #   value = aws_iam_role.cluster_autoscaler.arn
  # }

  depends_on = [module.eks]
}