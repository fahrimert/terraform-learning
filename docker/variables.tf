variable "container_name" {
  description = "Konteynerin ismi ne olsun?"
  type        = string
  default     = "benim-nginx-sunucum"
}

variable "host_port" {
  description = "Hangi porttan erisilecek?"
  type        = number
  default     = 8080
}
