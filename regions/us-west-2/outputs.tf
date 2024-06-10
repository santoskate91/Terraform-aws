# # terraform/regions/us-west-2/outputs.tf

# output "alb_dns_public" {
#   value = module.loadbalancer.aws_lb_load_balancer_public_dns_name
# }
# output "cf_dns" {
#   value = module.cloudfront.aws_cloudfront_distribution_cf_alb_domain_name
# }

output "tgw_u-west-2_id" {
  value = aws_ec2_transit_gateway.tgw_us-west-2.id
}
output "vpc_cidr_us-west-2_cidr_blocks" {
  value = module.vpc.vpc_cidr_us-west-2
}
output "tgw_us-west-2_peering_attachment_id_1" {
  value = aws_ec2_transit_gateway_peering_attachment.tgw_us-west-2_peering_attachment_1.id
}
output "tgw_us-west-2_peering_attachment_id_2" {
  value = aws_ec2_transit_gateway_peering_attachment.tgw_us-west-2_peering_attachment_2.id
}
