resource "aws_security_group" "example-cluster" {
  name        = "terraform-eks-example-cluster"
  description = "Cluster communication with worker nodes"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "demo-cluster-ingress-node-https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.example-cluster.id
  source_security_group_id = aws_security_group.example-cluster.id
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "demo-cluster-ingress-workstation-https" {
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.example-cluster.id
  to_port           = 443
  type              = "ingress"
}