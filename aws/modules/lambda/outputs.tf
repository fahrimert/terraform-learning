output "api_url" {
  description = "API Gateway URL"
  value       = "${aws_api_gateway_deployment.deployment.invoke_url}"
  sensitive = true
}

output "api_key_value" {
  value     = aws_api_gateway_api_key.my_key.value
  sensitive = true 
}
