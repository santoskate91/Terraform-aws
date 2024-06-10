# terraform/regions/ap-northeast-2/vpc_module/outputs.tf

output "vpc_seoul" {
  description = "VPC for security group"
  value       = aws_vpc.vpc_seoul.id
}

# output "public_subnet_1_vpc_seoul_id" {
#   description = "for instance"
#   value       = aws_subnet.public_subnet_1_vpc_seoul.id
# }
output "private_subnet_1_vpc_seoul_id" {
  description = "for instance"
  value       = aws_subnet.private_subnet_1_vpc_seoul.id
}
output "private_subnet_2_vpc_seoul_id" {
  description = "for instance"
  value       = aws_subnet.private_subnet_2_vpc_seoul.id
}

output "vpc_cidr_ap-northeast-2_cidr_blocks" {
  value = aws_vpc.vpc_seoul.cidr_block
}

output "route_private_subnet_vpc_seoul_id" {
  value = aws_route_table.route_private_subnet_vpc_seoul.id
}
