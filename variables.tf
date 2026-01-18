variable "aws_region" {
  description = "AWS Bölgesi"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "VPC icin IP blogu"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "Public Subnet IP blogu"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "Private Subnet IP blogu"
  type        = string
  default     = "10.0.2.0/24"
}

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