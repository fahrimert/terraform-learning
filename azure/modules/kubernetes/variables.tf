variable "resource_group_name" {}
variable "location" {}
variable "cluster_name" {
  default = "my-aks-cluster"
}
variable "node_count" {
  default = 1 
}