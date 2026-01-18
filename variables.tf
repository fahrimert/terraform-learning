variable "instance_type" {
  description = "EC2 sunucu tipi"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "Sunucu imaj ID'si"
  type        = string
  default     = "ami-df5de72ade3b42331" 
}