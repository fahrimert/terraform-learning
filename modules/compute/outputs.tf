output "server_public_ips" {
  description = "Tüm sunucularin IP adresleri"
  value       = aws_instance.web_server[*].public_ip
}