module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
}
module "compute" {
  source = "./modules/compute"

  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
}
