# ---------------------------------------------------
# 4. Helm: External Secrets with IRSA ServiceAccount
# ---------------------------------------------------
resource "helm_release" "external_secrets" {
  name       = "external-secrets"
  namespace  = "external-secrets"
  repository = "https://charts.external-secrets.io"
  chart      = "external-secrets"
  version    = "0.9.0"
  create_namespace = true

  set {
    name  = "serviceAccount.name"
    value = "external-secrets"
  }

  # set {
  #   name  = "serviceAccount.annotations[\"eks.amazonaws.com/role-arn\"]"
  #   value = aws_iam_role.external_secrets.arn
  # }

  set {
    name  = "installCRDs"
    value = "true"
  }

  depends_on = [module.eks]
}
