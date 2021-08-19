# cluster_master.tf

variable "cluster_name" {
    type    = string
    default = "example"
}

variable "kubernetes_version" {
    default = "1.20"
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
}