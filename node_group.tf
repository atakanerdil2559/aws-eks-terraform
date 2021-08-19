resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.example.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.node_group_role.arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.example-eks-worker-node-policy-attach,
    aws_iam_role_policy_attachment.example-eks-cni-policy-attach,
    aws_iam_role_policy_attachment.example-ec2-container-registry-policy-attach,
  ]
}