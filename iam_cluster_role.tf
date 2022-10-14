## EKS Cluster Role ###

resource "aws_iam_role" "cluster_role" {
  name = "eks-cluster-example-v2"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

### EKS Cluster Policy - Attachment (AmazonEKSClusterPolicy - AWS Managed Policy)###
resource "aws_iam_role_policy_attachment" "example-eks-cluster-policy-attach" {
  role       = aws_iam_role.cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

### EKS Cluster Policy - Attachment (AmazonEKSServicePolicy - AWS Managed Policy) ###
resource "aws_iam_role_policy_attachment" "example-eks-service-policy-attach" {
  role       = aws_iam_role.cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}