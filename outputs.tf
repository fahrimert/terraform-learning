output "web_server_public_ip" {
  description = "Web sunucusunun halka acik IP adresi"
  value       = aws_instance.web_server.public_ip
}

output "website_url" {
  description = "Web sitesine erisim linki"
  value       = "http://${aws_instance.web_server.public_ip}"
}

output "vpc_id" {
  description = "Olusturulan VPC'nin ID'si"
  value       = aws_vpc.main_vpc.id
}