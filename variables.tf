# cluster_master.tf

variable "cluster_name" {
    type    = string
    default = "example-cluster"
}

variable "kubernetes_version" {
    default = "1.20"
}

variable "vpc_id" {
    type    = string
}
variable "subnet_ids" {
    type    = list(string)
}

variable "security_group_ids" {
    type    = list(string)
}

# node_group.tf

variable "node_group_name" {
    type    = string
    default = "example-node-group"
}