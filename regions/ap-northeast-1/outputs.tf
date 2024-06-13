# terraform/regions/ap-northeast-1/outputs.tf

output "tgw_ap-northeast-1_id" {
  value = aws_ec2_transit_gateway.tgw_ap-northeast-1.id
}
output "vpc_cidr_ap-northeast-1_cidr_blocks" {
  value = module.vpc.vpc_cidr_ap-northeast-1_cidr_blocks
}
output "tgw_ap-northeast-1_peering_attachment" {
  value = aws_ec2_transit_gateway_peering_attachment_accepter.tgw_ap-northeast-1_peering_attachment
}

output "aws_instance_bastion_list_id" {
  value      = aws_instance.webserver[*].id
  depends_on = [aws_instance.webserver[0], aws_instance.webserver[1]]
}
output "load_balancer_private_dns_name" {
  value = module.loadbalancer.load_balancer_private_dns_name
}
