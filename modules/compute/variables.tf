variable "vpc_id" {
  description = "Sunucunun kurulacagi VPC ID"
  type        = string
}

variable "public_subnet_id" {
  description = "Sunucunun kurulacagi Subnet ID"
  type        = string
}

variable "ami_id" {
  default = "ami-df5de72ade3b42331"
}

variable "instance_type" {
  default = "t2.micro"
}