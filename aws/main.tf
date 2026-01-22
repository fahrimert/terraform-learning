module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
}
// module "compute" {
//   source = "./modules/compute"

//   vpc_id           = module.vpc.vpc_id
//   public_subnet_ids = module.vpc.public_subnet_ids
// }
module "serverless" {
  source = "./modules/lambda"
    
  table_name = module.database.table_name
  table_arn  = module.database.table_arn
}
output "api_endpoint" {
  value = "${module.serverless.api_url}/hello"
  sensitive = true
}

module "database" {
  source = "./modules/dynamodb"
  table_arn = module.database.table_arn
}
module "frontend" {
  source = "./modules/front"
  
  api_url = "${module.serverless.api_url}/hello"
  api_key = module.serverless.api_key_value
}

output "website_url" {
  value = module.frontend.website_url
}