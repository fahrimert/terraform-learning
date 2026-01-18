output "vpc_id" {
  description = "Olusturulan VPC'nin ID'si"
  value       = aws_vpc.main_vpc.id
}

output "public_subnet_id" {
  description = "Olusturulan public subnetin idsi"
  value = aws_subnet.public_subnet.id
  }

output "private_subnet_id" {
  description = "Olusturulan private subnetin idsi"
  value = aws_subnet.private_subnet.id
}

