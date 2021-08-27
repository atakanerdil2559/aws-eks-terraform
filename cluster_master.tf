resource "aws_eks_cluster" "example" {
  name      = var.cluster_name
  role_arn  = aws_iam_role.cluster_role.arn
  version   = var.kubernetes_version
  vpc_config {
    subnet_ids          = var.subnet_ids
    security_group_ids  = ["${aws_security_group.example-cluster.id}"]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.example-eks-cluster-policy-attach,
    aws_iam_role_policy_attachment.example-eks-service-policy-attach,
  ]
}