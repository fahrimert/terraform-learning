include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules/s3-bucket"
}

inputs = {
  bucket_name = "mert-terragrunt-app-prod-2026" 
  env         = "prod"
}
