# terraform/regions/ap-northeast-2/vpc_module/main.tf

resource "aws_vpc" "vpc_seoul" {
  cidr_block           = var.vpc_cidr_seoul
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "vpc_seoul"
  }
}
# # public subnet
# resource "aws_subnet" "public_subnet_1_vpc_seoul" {
#   vpc_id                  = aws_vpc.vpc_seoul.id
#   cidr_block              = var.public_subnet_1_cidr_seoul
#   availability_zone       = var.availability_zones_seoul[0]
#   map_public_ip_on_launch = "true"

#   tags = {
#     Name = "public_subnet_1_vpc_seoul"
#   }
# }
resource "aws_subnet" "private_subnet_1_vpc_seoul" {
  vpc_id                  = aws_vpc.vpc_seoul.id
  cidr_block              = var.private_subnet_1_cidr_seoul
  availability_zone       = var.availability_zones_seoul[0]
  map_public_ip_on_launch = "true"

  tags = {
    Name = "private_subnet_1_vpc_seoul"
  }
}
resource "aws_subnet" "private_subnet_2_vpc_seoul" {
  vpc_id                  = aws_vpc.vpc_seoul.id
  cidr_block              = var.private_subnet_2_cidr_seoul
  availability_zone       = var.availability_zones_seoul[1]
  map_public_ip_on_launch = "true"

  tags = {
    Name = "private_subnet_1_vpc_seoul"
  }
}
# # internet gateway
# resource "aws_internet_gateway" "igw_vpc_seoul" {
#   vpc_id = aws_vpc.vpc_seoul.id

#   tags = {
#     Name = "igw_vpc_seoul"
#   }
# }
# route
# resource "aws_route_table" "route_public_subnet_vpc_seoul" {
#   vpc_id = aws_vpc.vpc_seoul.id

#   tags = {
#     Name = "route_public_subnet_vpc_seoul"
#   }

#   #   route {
#   #     cidr_block = "0.0.0.0/0"
#   #     gateway_id = aws_internet_gateway.igw_vpc_seoul.id
#   #   }
# }
resource "aws_route_table" "route_private_subnet_vpc_seoul" {
  vpc_id = aws_vpc.vpc_seoul.id

  tags = {
    Name = "route_private_subnet_vpc_seoul"
  }
}
# associate route
# resource "aws_route_table_association" "public_route_1_association_vpc_seoul" {
#   subnet_id      = aws_subnet.public_subnet_1_vpc_seoul.id
#   route_table_id = aws_route_table.route_public_subnet_vpc_seoul.id
# }
resource "aws_route_table_association" "private_route_1_association_vpc_seoul" {
  subnet_id      = aws_subnet.private_subnet_1_vpc_seoul.id
  route_table_id = aws_route_table.route_private_subnet_vpc_seoul.id
}
resource "aws_route_table_association" "private_route_2_association_vpc_seoul" {
  subnet_id      = aws_subnet.private_subnet_2_vpc_seoul.id
  route_table_id = aws_route_table.route_private_subnet_vpc_seoul.id
}
