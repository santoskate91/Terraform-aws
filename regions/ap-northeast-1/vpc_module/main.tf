# terraform/regions/ap-northeast-1/vpc_module/main.tf

resource "aws_vpc" "vpc_tokyo" {
  cidr_block           = var.vpc_cidr_tokyo
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
  cidr_block              = var.public_subnet_1_cidr_tokyo
  availability_zone       = var.availability_zones_tokyo[0]
  map_public_ip_on_launch = "true"

  tags = {
    Name = "public_subnet_1_vpc_tokyo"
  }
}
resource "aws_subnet" "private_subnet_1_vpc_tokyo" {
  vpc_id                  = aws_vpc.vpc_tokyo.id
  cidr_block              = var.private_subnet_1_cidr_tokyo
  availability_zone       = var.availability_zones_tokyo[0]
  map_public_ip_on_launch = "true"

  tags = {
    Name = "private_subnet_1_vpc_tokyo"
  }
}
resource "aws_subnet" "private_subnet_2_vpc_tokyo" {
  vpc_id                  = aws_vpc.vpc_tokyo.id
  cidr_block              = var.private_subnet_2_cidr_tokyo
  availability_zone       = var.availability_zones_tokyo[1]
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
}
resource "aws_route_table" "route_private_subnet_vpc_tokyo" {
  vpc_id = aws_vpc.vpc_tokyo.id

  tags = {
    Name = "route_private_subnet_vpc_tokyo"
  }
}
# nat gateway
resource "aws_eip" "eip_natgw" {
  associate_with_private_ip = "11.0.0.5"
  depends_on                = [aws_internet_gateway.igw_vpc_tokyo]

  tags = {
    Name = "EIP_for_NAT"
  }
}
resource "aws_nat_gateway" "natgw_vpc_tokyo" {
  allocation_id = aws_eip.eip_natgw.id
  # connectivity_type = "private"
  subnet_id  = aws_subnet.public_subnet_1_vpc_tokyo.id
  depends_on = [aws_eip.eip_natgw]

  tags = {
    Name = "natgw_vpc_tokyo"
  }
}

# route public subnet through theinternet gateway แทน route in aws_route_table ได้
resource "aws_route" "internet_igw_route" {
  route_table_id         = aws_route_table.route_public_subnet_vpc_tokyo.id
  gateway_id             = aws_internet_gateway.igw_vpc_tokyo.id
  destination_cidr_block = "0.0.0.0/0"
}
resource "aws_route" "nat_gateway_route" {
  route_table_id         = aws_route_table.route_private_subnet_vpc_tokyo.id
  nat_gateway_id         = aws_nat_gateway.natgw_vpc_tokyo.id
  destination_cidr_block = "0.0.0.0/0"
}
# associate route
resource "aws_route_table_association" "public_route_1_association_vpc_tokyo" {
  subnet_id      = aws_subnet.public_subnet_1_vpc_tokyo.id
  route_table_id = aws_route_table.route_public_subnet_vpc_tokyo.id
}
resource "aws_route_table_association" "private_route_1_association_vpc_tokyo" {
  subnet_id      = aws_subnet.private_subnet_1_vpc_tokyo.id
  route_table_id = aws_route_table.route_private_subnet_vpc_tokyo.id
}
resource "aws_route_table_association" "private_route_2_association_vpc_tokyo" {
  subnet_id      = aws_subnet.private_subnet_2_vpc_tokyo.id
  route_table_id = aws_route_table.route_private_subnet_vpc_tokyo.id
}
