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

  vpc_id               = module.vpc.vpc_id
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "internet_gateway" {
  source = "./modules/internet_gateway"

  vpc_id = module.vpc.vpc_id
}

module "public_route_table" {
  source = "./modules/public_route_table"

  vpc_id                  = module.vpc.vpc_id
  public_subnet_ids       = module.public_subnets.public_subnet_ids
  public_route_table_cidr = var.public_route_table_cidr
  internet_gateway_id     = module.internet_gateway.internet_gateway_id
}

module "private_route_table" {
  source = "./modules/private_route_table"

  vpc_id                   = module.vpc.vpc_id
  private_subnet_ids       = module.private_subnets.private_subnet_ids
  private_route_table_cidr = var.private_route_table_cidr
}

resource "aws_security_group" "security_group" {
  name = "application"
  depends_on = [
    module.vpc
  ]

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = module.vpc.vpc_id
}

resource "aws_instance" "ec2_instance" {
  ami                     = var.ami_id
  instance_type           = var.instance_type
  subnet_id               = module.public_subnets.public_subnet_ids[0]
  vpc_security_group_ids  = [aws_security_group.security_group.id]
  disable_api_termination = false
  depends_on = [
    aws_security_group.security_group
  ]
  root_block_device {
    volume_size = var.instance_volume_size
    volume_type = var.instance_volume_type
  }
  tags = {
    Name = "Webapp Instance"
  }
}