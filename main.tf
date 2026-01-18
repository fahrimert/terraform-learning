resource "aws_s3_bucket" "terraform-learning-local-bucket" {
  bucket = "terraform-learning-local-bucket"
  
  tags = {
    Name        = "Terraform Learning Local Bucket"
    Environment = "Dev"
  }
}