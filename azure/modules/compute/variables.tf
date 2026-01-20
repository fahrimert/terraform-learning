variable "resource_group_name" {}
variable "location" {}
variable "vm_size" {}
variable "nic_id" {
  description = "Network modülünden gelen NIC ID"
}

variable "ssh_public_key" {
  description = "SSH Public Key content"
  type        = string
}