
variable "region" {
  type        = string
  description = "AWS region to use"
}

variable "vpc_cidr_block" {
  type        = string
  description = "VPC CIDR block"
}

variable "profile" {
  type        = string
  description = "Profile to use for deployment"
}

variable "public_subnet_count" {
  type = number
}

variable "private_subnet_count" {
  type = number
}

variable "instance_type" {
  type    = string
  default = "t2.micro"

}

variable "instance_volume_size" {
  type    = number
  default = 50
}

variable "app_port" {
  type    = number
  default = 8000
}

variable "ami_id" {
  type = string
}

variable "instance_volume_type" {
  type    = string
  default = "gp2"
}

variable "db_engine" {
  type    = string
  default = "mysql"
}

variable "db_instance" {
  type    = string
  default = "db.t3.micro"
}

variable "db_multi_az" {
  type    = bool
  default = false
}

variable "db_instance_identifier" {
  type    = string
  default = "csye6225"
}

variable "db_username" {
  type    = string
  default = "csye6225"
}

variable "db_password" {
  type = string
}

variable "db_name" {
  type    = string
  default = "csye6225"
}

variable "AWS_ACCESS_KEY_ID" {
  type = string
}

variable "AWS_SECRET_ACCESS_KEY" {
  type = string
}

locals {
  public_subnets  = [for i in range(1, var.public_subnet_count + 1) : cidrsubnet(var.vpc_cidr_block, 8, i)]
  private_subnets = [for i in range(1, var.private_subnet_count + 1) : cidrsubnet(var.vpc_cidr_block, 8, i + var.private_subnet_count)]
}