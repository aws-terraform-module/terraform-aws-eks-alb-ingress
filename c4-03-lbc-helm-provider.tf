# Datasource: EKS Cluster Auth 
data "aws_eks_cluster_auth" "cluster" {
  name = var.eks_cluster_name
}

# HELM Provider
# Since Helm provider v3.0, the nested `kubernetes` block has been replaced
# with top-level attributes on the provider configuration.
# Ref: https://github.com/hashicorp/terraform-provider-helm/issues/1637
provider "helm" {
  host                   = var.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(var.eks_cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}
