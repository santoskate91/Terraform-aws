# terraform/regions/ap-northeast-1/transit.tf

resource "aws_ec2_transit_gateway" "tgw_ap-northeast-1" {
  description                     = "Transit Gateway in region 1"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  tags = {
    Name = "TGW-ap-northeast-1"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_ap-northeast-1_vpc-attachment" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw_ap-northeast-1.id
  vpc_id             = module.vpc.vpc_tokyo
  subnet_ids         = [module.vpc.private_subnet_1_vpc_tokyo]
  tags = {
    Name = "transit_vpc_attachment"
  }
}

resource "aws_ec2_transit_gateway_peering_attachment_accepter" "tgw_ap-northeast-1_peering_attachment" {
  transit_gateway_attachment_id = var.tgw_us-west-2_peering_attachment_id
  tags = {
    Name = "transit_peer_attachment"
  }
  depends_on = [var.tgw_us-west-2_peering_attachment_id]
}

resource "aws_ec2_transit_gateway_route_table" "tgw_ap-northeast-1_route_table" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw_ap-northeast-1.id
  tags = {
    Name = "route_table_TGW"
  }
}

resource "aws_ec2_transit_gateway_route_table_association" "peering_association" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment_accepter.tgw_ap-northeast-1_peering_attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_ap-northeast-1_route_table.id
}
resource "aws_ec2_transit_gateway_route_table_association" "vpc_association" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_ap-northeast-1_vpc-attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_ap-northeast-1_route_table.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "vpc_propagation" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_ap-northeast-1_vpc-attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_ap-northeast-1_route_table.id
}

resource "aws_ec2_transit_gateway_route" "route_between_region" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_ap-northeast-1_route_table.id
  destination_cidr_block         = var.vpc_cidr_us-west-2
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment_accepter.tgw_ap-northeast-1_peering_attachment.id
}

# For vpc route TransitGateWay
resource "aws_route" "us-west-2_to_ap-northeast-1" {
  route_table_id         = module.vpc.route_private_subnet_vpc_tokyo_id
  destination_cidr_block = var.vpc_cidr_us-west-2
  transit_gateway_id     = aws_ec2_transit_gateway.tgw_ap-northeast-1.id
}
