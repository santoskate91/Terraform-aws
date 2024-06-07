# terraform/regions/ap-northeast-1/outputs.tf

output "tgw_ap-northeast-1_id" {
  value = aws_ec2_transit_gateway.tgw_ap-northeast-1.id
}
output "vpc_cidr_ap-northeast-1_cidr_blocks" {
  value = module.vpc.vpc_cidr_ap-northeast-1
}
output "tgw_ap-northeast-1_peering_attachment" {
  value = aws_ec2_transit_gateway_peering_attachment_accepter.tgw_ap-northeast-1_peering_attachment
}
