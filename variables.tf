variable "region" {
  description = "The region to create the VPC in"
  type        = string
  # default     = "us-east-1"
}

variable "profile" {
  description = "The profile is the account where to deploy the infrastructure"
  type        = string
  # default = "dev"
}

variable "vpc_cidr" {
  description = "The IP range for the VPC"
  default = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "The availability zones to create subnets in"
  type        = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "public_subnet_cidrs" {
  description = "The IP ranges for the public subnets"
  type        = list(string)
  default = ["10.0.16.0/20", "10.0.32.0/20", "10.0.48.0/20"]
}

variable "private_subnet_cidrs" {
  description = "The IP ranges for the private subnets"
  type        = list(string)
  default = ["10.0.64.0/18", "10.0.128.0/18", "10.0.192.0/18"]
}

variable "public_route_table_cidr" {
  type        = string
  description = "The CIDR block of the public route table"
  default = "0.0.0.0/0"
}

variable "private_route_table_cidr" {
  type        = string
  description = "The CIDR block of the private route table"
  default = "0.0.0.0/0"
}

