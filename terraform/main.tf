
data "aws_availability_zones" "zones" {
  state = "available"
}


resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "CloudVPC"
  }
}

resource "aws_subnet" "public_subnets" {
  count                   = var.public_subnet_count
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = local.public_subnets[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.zones.names[count.index]
  tags = {
    Name = "Public Subnet ${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnets" {
  count                   = var.private_subnet_count
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = local.private_subnets[count.index]
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.zones.names[count.index]
  tags = {
    Name = "Private Subnet  ${count.index + 1}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "CloudIGW"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "CloudPublic_Route_Table"
  }

}

resource "aws_route_table_association" "public_route_table_association" {
  count          = var.public_subnet_count
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "CloudPrivate_Route_Table"
  }
}

resource "aws_route_table_association" "private_route_table_association" {
  count          = var.private_subnet_count
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
