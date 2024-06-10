# terraform/regions/ap-northeast-2/transit.tf

resource "aws_ec2_transit_gateway" "tgw_ap-northeast-2" {
  description                     = "Transit Gateway in region ap-northeast-2"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  tags = {
    Name = "TGW-ap-northeast-2"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_ap-northeast-2_vpc-attachment" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw_ap-northeast-2.id
  vpc_id             = module.vpc.vpc_seoul
  subnet_ids         = [module.vpc.private_subnet_1_vpc_seoul_id]
  tags = {
    Name = "transit_vpc_attachment"
  }
}

resource "aws_ec2_transit_gateway_peering_attachment_accepter" "tgw_ap-northeast-2_peering_attachment" {
  transit_gateway_attachment_id = var.tgw_us-west-2_peering_attachment_id_2
  tags = {
    Name = "transit_peer_attachment"
  }
  depends_on = [var.tgw_us-west-2_peering_attachment_id_2]
}

resource "aws_ec2_transit_gateway_route_table" "tgw_ap-northeast-2_route_table" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw_ap-northeast-2.id
  tags = {
    Name = "route_table_TGW"
  }
}

resource "aws_ec2_transit_gateway_route_table_association" "peering_association" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment_accepter.tgw_ap-northeast-2_peering_attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_ap-northeast-2_route_table.id
}
resource "aws_ec2_transit_gateway_route_table_association" "vpc_association" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_ap-northeast-2_vpc-attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_ap-northeast-2_route_table.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "vpc_propagation" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_ap-northeast-2_vpc-attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_ap-northeast-2_route_table.id
}

resource "aws_ec2_transit_gateway_route" "route_between_region_us" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_ap-northeast-2_route_table.id
  destination_cidr_block         = var.vpc_cidr_us-west-2
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment_accepter.tgw_ap-northeast-2_peering_attachment.id
}
resource "aws_ec2_transit_gateway_route" "route_between_region_ap1" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_ap-northeast-2_route_table.id
  destination_cidr_block         = var.vpc_cidr_ap-northeast-1
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment_accepter.tgw_ap-northeast-2_peering_attachment.id
}


# For vpc route TransitGateWay
resource "aws_route" "us-west-2_to_ap-northeast-2_to_us" {
  route_table_id         = module.vpc.route_private_subnet_vpc_seoul_id
  destination_cidr_block = var.vpc_cidr_us-west-2
  transit_gateway_id     = aws_ec2_transit_gateway.tgw_ap-northeast-2.id
}
resource "aws_route" "us-west-2_to_ap-northeast-2_to_ap1" {
  route_table_id         = module.vpc.route_private_subnet_vpc_seoul_id
  destination_cidr_block = var.vpc_cidr_ap-northeast-1
  transit_gateway_id     = aws_ec2_transit_gateway.tgw_ap-northeast-2.id
}
