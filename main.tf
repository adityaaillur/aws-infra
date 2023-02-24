module "vpc" {
  source = "./modules/vpc"

  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "public_subnets" {
  source = "./modules/public_subnets"

  vpc_id              = module.vpc.vpc_id
  public_subnet_cidrs = var.public_subnet_cidrs
  availability_zones  = var.availability_zones
}

module "private_subnets" {
  source = "./modules/private_subnets"

  vpc_id             = module.vpc.vpc_id
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones = var.availability_zones
}

module "internet_gateway" {
  source = "./modules/internet_gateway"

  vpc_id = module.vpc.vpc_id
}

module "public_route_table" {
  source = "./modules/public_route_table"

  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.public_subnets.public_subnet_ids
  public_route_table_cidr = var.public_route_table_cidr
  internet_gateway_id = module.internet_gateway.internet_gateway_id
}

module "private_route_table" {
  source = "./modules/private_route_table"

  vpc_id                  = module.vpc.vpc_id
  private_subnet_ids      = module.private_subnets.private_subnet_ids
  private_route_table_cidr = var.private_route_table_cidr
}