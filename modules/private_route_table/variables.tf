variable "vpc_id" {
  description = "The ID of the VPC"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of IDs of private subnets"
}

variable "private_route_table_cidr" {
  type        = string
  description = "CIDR block for private route table"
}
