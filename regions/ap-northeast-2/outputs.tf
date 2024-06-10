# terraform/regions/ap-northeast-2/outputs.tf

output "tgw_ap-northeast-2_id" {
  value = aws_ec2_transit_gateway.tgw_ap-northeast-2.id
}
output "vpc_cidr_ap-northeast-2_cidr_blocks" {
  value = module.vpc.vpc_cidr_ap-northeast-2_cidr_blocks
}
output "tgw_ap-northeast-2_peering_attachment" {
  value = aws_ec2_transit_gateway_peering_attachment_accepter.tgw_ap-northeast-2_peering_attachment
}
output "trail_logs" {
  value = aws_s3_bucket.trail_logs
}
