resource "aws_ec2_transit_gateway" "this" {
  description = "Transit Gateway in region 1"
}
resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  transit_gateway_id = aws_ec2_transit_gateway.this.id
  vpc_id             = module.vpc.vpc_1_id
  subnet_ids         = [module.vpc.private_subnet_1_vpc_1_id]
}
