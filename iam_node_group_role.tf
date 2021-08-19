## EKS Node Group Role ###

resource "aws_iam_role" "node_group_role" {
  name = "eks-node-group-example"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

### EKS Cluster Policy - Attachment (AmazonEKSWorkerNodePolicy - AWS Managed Policy)###
resource "aws_iam_role_policy_attachment" "example-eks-worker-node-policy-attach" {
  role       = aws_iam_role.node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

### EKS Cluster Policy - Attachment (AmazonEKS_CNI_Policy - AWS Managed Policy) ###
resource "aws_iam_role_policy_attachment" "example-eks-cni-policy-attach" {
  role       = aws_iam_role.node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

### EKS Cluster Policy - Attachment (AmazonEC2ContainerRegistryReadOnly - AWS Managed Policy) ###
resource "aws_iam_role_policy_attachment" "example-ec2-container-registry-policy-attach" {
  role       = aws_iam_role.node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}