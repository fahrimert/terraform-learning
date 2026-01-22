data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/src/hello.py"
  output_path = "${path.module}/src/hello.zip"
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_lambda_function" "test_lambda" {
  filename      = data.archive_file.lambda_zip.output_path
  function_name = "hello-world-function"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "hello.lambda_handler"
  runtime       = "python3.9"
  environment {
    variables = {
      TABLE_NAME = var.table_name
    }
  }
  
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
}


resource "aws_iam_role_policy" "lambda_dynamo_policy" {
  name = "lambda_dynamo_policy"
  role = aws_iam_role.iam_for_lambda.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:Scan"
        ]
        Effect   = "Allow"
        Resource = var.table_arn
      },
    ]
  })
}