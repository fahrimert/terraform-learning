resource "aws_dynamodb_table" "basic_dynamodb_table" {
  name           = "VisitorsTable"
  billing_mode   = "PAY_PER_REQUEST" 
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

output "table_name" {
  value = aws_dynamodb_table.basic_dynamodb_table.name
}

