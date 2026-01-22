output "table_arn" {
  description = "DynamoDB Tablosunun ARN'si"
  value       = aws_dynamodb_table.basic_dynamodb_table.arn
}
