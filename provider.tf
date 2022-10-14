provider "aws" {
  region  = "us-east-1"
}

provider "kubernetes" {	
  load_config_file       = "false"
  host                   = data.aws_eks_cluster.example.endpoint
  token                  = data.aws_eks_cluster_auth.example.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.example.certificate_authority.0.data)
}