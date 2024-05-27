# terraform/regions/us-west-2/vpc_module/main.tf

# For vpc
resource "aws_vpc" "vpc_1" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "vpc_1"
  }
}

# For subnet
# public subnet
resource "aws_subnet" "public_sebnet_1_vpc_1" {
  vpc_id            = aws_vpc.vpc_1.id
  cidr_block        = var.public_subnet_1_cidr
  availability_zone = var.availability_zones[0]
  # มีผลต่อ ec2 public ip ตอนสร้าง intsance
  map_public_ip_on_launch = "true"

  tags = {
    Name = "public_sebnet_1_vpc_1"
  }
}
resource "aws_subnet" "public_subnet_2_vpc_1" {
  vpc_id                  = aws_vpc.vpc_1.id
  cidr_block              = var.public_subnet_2_cidr
  availability_zone       = var.availability_zones[1]
  map_public_ip_on_launch = "true"

  tags = {
    Name = "public_subnet_2_vpc_1"
  }
}
# private subnet
resource "aws_subnet" "private_subnet_1_vpc_1" {
  vpc_id                  = aws_vpc.vpc_1.id
  cidr_block              = var.private_subnet_1_cidr
  availability_zone       = var.availability_zones[0]
  map_public_ip_on_launch = "true"

  tags = {
    Name = "private_subnet_1_vpc_1"
  }
}
resource "aws_subnet" "private_subnet_2_vpc_1" {
  vpc_id                  = aws_vpc.vpc_1.id
  cidr_block              = var.private_subnet_2_cidr
  availability_zone       = var.availability_zones[1]
  map_public_ip_on_launch = "true"

  tags = {
    Name = "private_subnet_2_vpc_1"
  }
}

# For gateway
# internet gateway
resource "aws_internet_gateway" "igw_vpc_1" {
  vpc_id = aws_vpc.vpc_1.id

  tags = {
    Name = "igw_vpc_1"
  }
}
# # nat gateway
# resource "aws_eip" "eip_natgw" {
#   associate_with_private_ip = "10.0.0.5"
#   depends_on                = [aws_internet_gateway.igw_vpc_1]

#   tags = {
#     Name = "EIP_for_NAT"
#   }
# }
# resource "aws_nat_gateway" "natgw_vpc_1" {
#   allocation_id = aws_eip.eip_natgw.id
#   # connectivity_type = "private"
#   subnet_id  = aws_subnet.public_sebnet_1_vpc_1.id
#   depends_on = [aws_eip.eip_natgw]

#   tags = {
#     Name = "natgw_vpc_1"
#   }
# }

# For route table
# Create route
resource "aws_route_table" "route_public_subnet_vpc_1" {
  vpc_id = aws_vpc.vpc_1.id

  tags = {
    Name = "route_public_subnet_vpc_1"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_vpc_1.id
  }
}
resource "aws_route_table" "route_private_subnet_vpc_1" {
  vpc_id = aws_vpc.vpc_1.id

  tags = {
    Name = "route_private_subnet_vpc_1"
  }

  # route {
  #   cidr_block = "0.0.0.0/0"
  #   gateway_id = aws_nat_gateway.natgw_vpc_1.id
  # }
}

# # route public subnet through theinternet gateway แทน route in aws_route_table ได้
# resource "aws_route" "internet_igw_route" {
#   route_table_id         = aws_route_table.route_public_subnet_vpc_1.id
#   gateway_id             = aws_internet_gateway.igw_vpc_1.id
#   destination_cidr_block = "0.0.0.0/0"
# }
# resource "aws_route" "nat_gateway_route" {
#   route_table_id         = aws_route_table.route_private_subnet_vpc_1.id
#   nat_gateway_id         = aws_nat_gateway.natgw_vpc_1.id
#   destination_cidr_block = "0.0.0.0/0"
# }

# Associate route to subnet
resource "aws_route_table_association" "public_route_1_association" {
  subnet_id      = aws_subnet.public_sebnet_1_vpc_1.id
  route_table_id = aws_route_table.route_public_subnet_vpc_1.id
}
resource "aws_route_table_association" "public_route_2_association" {
  subnet_id      = aws_subnet.public_subnet_2_vpc_1.id
  route_table_id = aws_route_table.route_public_subnet_vpc_1.id
}
resource "aws_route_table_association" "private_route_1_association" {
  subnet_id      = aws_subnet.private_subnet_1_vpc_1.id
  route_table_id = aws_route_table.route_private_subnet_vpc_1.id
}
resource "aws_route_table_association" "private_route_2_association" {
  subnet_id      = aws_subnet.private_subnet_2_vpc_1.id
  route_table_id = aws_route_table.route_private_subnet_vpc_1.id
}

# For vpc 2
resource "aws_vpc" "vpc_2" {
  cidr_block           = var.vpc_2_cidr
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "vpc_2"
  }
}
# public subnet
resource "aws_subnet" "public_subnet_1_vpc_2" {
  vpc_id                  = aws_vpc.vpc_2.id
  cidr_block              = var.public_subnet_1_cidr_vpc_2
  availability_zone       = var.availability_zones[0]
  map_public_ip_on_launch = "true"

  tags = {
    Name = "public_subnet_1_vpc_2"
  }
}
resource "aws_subnet" "private_subnet_1_vcp_2" {
  vpc_id                  = aws_vpc.vpc_2.id
  cidr_block              = var.private_subnet_1_cidr_vpc_2
  availability_zone       = var.availability_zones[0]
  map_public_ip_on_launch = "true"

  tags = {
    Name = "private_subnet_1_vpc_2"
  }
}
# internet gateway
resource "aws_internet_gateway" "igw_vpc_2" {
  vpc_id = aws_vpc.vpc_2.id

  tags = {
    Name = "igw_vpc_2"
  }
}
# route
resource "aws_route_table" "route_public_subnet_vpc_2" {
  vpc_id = aws_vpc.vpc_2.id

  tags = {
    Name = "route_public_subnet_vpc_2"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_vpc_2.id
  }
}
resource "aws_route_table" "route_private_subnet_vpc_2" {
  vpc_id = aws_vpc.vpc_2.id

  tags = {
    Name = "route_private_subnet_vpc_2"
  }
}
# associate route
resource "aws_route_table_association" "public_route_1_association_vpc_2" {
  subnet_id      = aws_subnet.public_subnet_1_vpc_2.id
  route_table_id = aws_route_table.route_public_subnet_vpc_2.id
}
resource "aws_route_table_association" "private_route_1_association_vpc_2" {
  subnet_id      = aws_subnet.private_subnet_1_vcp_2.id
  route_table_id = aws_route_table.route_private_subnet_vpc_2.id
}
