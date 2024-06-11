# terraform/regions/us-west-2/transit.tf

resource "aws_ec2_transit_gateway" "tgw_us-west-2" {
  description                     = "Transit Gateway in region 1"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  tags = {
    Name = "TGW-us-west-2"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_us-west-2_vpc-attachment" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw_us-west-2.id
  vpc_id             = module.vpc.vpc_1_id
  subnet_ids = [module.vpc.private_subnet_1_vpc_1_id
    # , module.vpc.private_subnet_2_vpc_1_id
  ]
  tags = {
    Name = "transit_vpc_attachment"
  }
}

# peering another region
resource "aws_ec2_transit_gateway_peering_attachment" "tgw_us-west-2_peering_attachment_1" {
  peer_region             = var.peering_region_ap-northeast-1
  peer_transit_gateway_id = var.tgw_ap-northeast-1_id
  transit_gateway_id      = aws_ec2_transit_gateway.tgw_us-west-2.id
  tags = {
    Name = "transit_peer_attachment_ap1"
  }
}
resource "aws_ec2_transit_gateway_peering_attachment" "tgw_us-west-2_peering_attachment_2" {
  peer_region             = var.peering_region_ap-northeast-2
  peer_transit_gateway_id = var.tgw_ap-northeast-2_id
  transit_gateway_id      = aws_ec2_transit_gateway.tgw_us-west-2.id
  tags = {
    Name = "transit_peer_attachment_ap2"
  }
}


resource "aws_ec2_transit_gateway_route_table" "tgw_us-west-2_route_table" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw_us-west-2.id
  tags = {
    Name = "route_table_TGW"
  }
}

resource "aws_ec2_transit_gateway_route_table_association" "vpc_association" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_us-west-2_vpc-attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_us-west-2_route_table.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "vpc_propagation" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_us-west-2_vpc-attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_us-west-2_route_table.id
}

resource "aws_ec2_transit_gateway_route_table_association" "peering_association_ap1" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.tgw_us-west-2_peering_attachment_1.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_us-west-2_route_table.id

  depends_on = [
    var.tgw_ap-northeast-1_peering_attachment
  ]
}
resource "aws_ec2_transit_gateway_route_table_association" "peering_association_ap2" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.tgw_us-west-2_peering_attachment_2.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_us-west-2_route_table.id

  depends_on = [
    var.tgw_ap-northeast-2_peering_attachment
  ]
}
resource "aws_ec2_transit_gateway_route" "route_between_region_1" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_us-west-2_route_table.id
  destination_cidr_block         = var.vpc_cidr_ap-northeast-1
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.tgw_us-west-2_peering_attachment_1.id

  depends_on = [
    var.tgw_ap-northeast-1_peering_attachment
  ]
}
resource "aws_ec2_transit_gateway_route" "route_between_region_2" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_us-west-2_route_table.id
  destination_cidr_block         = var.vpc_cidr_ap-northeast-2
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.tgw_us-west-2_peering_attachment_1.id

  depends_on = [
    var.tgw_ap-northeast-2_peering_attachment
  ]
}
# For vpc route TransitGateWay
resource "aws_route" "us-west-2_to_ap-northeast-1" {
  route_table_id         = module.vpc.route_private_subnet_vpc_1_id
  destination_cidr_block = var.vpc_cidr_ap-northeast-1
  transit_gateway_id     = aws_ec2_transit_gateway.tgw_us-west-2.id
}
resource "aws_route" "us-west-2_to_ap-northeast-2" {
  route_table_id         = module.vpc.route_private_subnet_vpc_1_id
  destination_cidr_block = var.vpc_cidr_ap-northeast-2
  transit_gateway_id     = aws_ec2_transit_gateway.tgw_us-west-2.id
}
