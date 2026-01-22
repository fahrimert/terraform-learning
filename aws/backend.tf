terraform {
  backend "s3" {
    bucket         = "terraform-state-storage" 
    key            = "global/s3/terraform.tfstate" 
    region         = "us-east-1"
    
    encrypt        = true

    endpoints = {
      s3       = "http://localhost:4566"
      dynamodb = "http://localhost:4566"
    }
    
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
    skip_region_validation      = true
    force_path_style            = true
  }
}