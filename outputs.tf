output "web_server_public_ip" {
  description = "Web sunucusunun halka acik IP adresi"
  value       = aws_instance.web_server.public_ip
}

output "website_url" {
  description = "Web sitesine erisim linki"
  value       = "http://${aws_instance.web_server.public_ip}"
}

