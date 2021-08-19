output "cluster_role" {
  value = aws_iam_role.cluster_role.arn
}

output "node_group_role" {
  value = aws_iam_role.node_group_role.arn
}

output "endpoint" {
  value = aws_eks_cluster.example.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.example.certificate_authority[0].data
}