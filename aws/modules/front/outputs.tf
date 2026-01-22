output "website_url" {
  value = "http://${aws_s3_bucket.website_bucket.bucket}.s3-website.us-east-1.amazonaws.com"
}
