# terraform/regions/ap-northeast-1/vpc_module/main.tf

# For vpc 2
resource "aws_vpc" "vpc_tokyo" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "vpc_tokyo"
  }
}
# public subnet
resource "aws_subnet" "public_subnet_1_vpc_tokyo" {
  vpc_id                  = aws_vpc.vpc_tokyo.id
  cidr_block              = var.public_subnet_1_cidr
  availability_zone       = var.availability_zones[0]
  map_public_ip_on_launch = "true"

  tags = {
    Name = "public_subnet_1_vpc_tokyo"
  }
}
resource "aws_subnet" "private_subnet_1_vcp_2" {
  vpc_id                  = aws_vpc.vpc_tokyo.id
  cidr_block              = var.private_subnet_1_cidr
  availability_zone       = var.availability_zones[0]
  map_public_ip_on_launch = "true"

  tags = {
    Name = "private_subnet_1_vpc_tokyo"
  }
}
# internet gateway
resource "aws_internet_gateway" "igw_vpc_tokyo" {
  vpc_id = aws_vpc.vpc_tokyo.id

  tags = {
    Name = "igw_vpc_tokyo"
  }
}
# route
resource "aws_route_table" "route_public_subnet_vpc_tokyo" {
  vpc_id = aws_vpc.vpc_tokyo.id

  tags = {
    Name = "route_public_subnet_vpc_tokyo"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_vpc_tokyo.id
  }
}
resource "aws_route_table" "route_private_subnet_vpc_tokyo" {
  vpc_id = aws_vpc.vpc_tokyo.id

  tags = {
    Name = "route_private_subnet_vpc_tokyo"
  }
}
# associate route
resource "aws_route_table_association" "public_route_1_association_vpc_tokyo" {
  subnet_id      = aws_subnet.public_subnet_1_vpc_tokyo.id
  route_table_id = aws_route_table.route_public_subnet_vpc_tokyo.id
}
resource "aws_route_table_association" "private_route_1_association_vpc_tokyo" {
  subnet_id      = aws_subnet.private_subnet_1_vcp_2.id
  route_table_id = aws_route_table.route_private_subnet_vpc_tokyo.id
}
