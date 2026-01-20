variable "location" {
  description = "Kaynakların kurulacağı Azure bölgesi"
  default     = "France Central"
}

variable "vm_size" {
  description = "Sanal makine boyutu"
  default     = "Standard_D2s_v3"
}

variable "resource_group_name" {
  description = "Kaynak grubu ismi"
  default     = "terraform-azure-rg-final-v4"
}