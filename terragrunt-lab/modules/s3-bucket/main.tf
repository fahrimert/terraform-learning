resource "aws_s3_bucket" "b" {
  bucket = var.bucket_name
  
  tags = {
    Environment = var.env
    CreatedBy   = "Terragrunt"
  }
}
