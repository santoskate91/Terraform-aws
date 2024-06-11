# terraform/regions/ap-northeast-1/vpc_module/outputs.tf

output "vpc_tokyo" {
  description = "VPC for security group"
  value       = aws_vpc.vpc_tokyo.id
}

# output "public_subnet_1_vpc_tokyo" {
#   description = "for instance"
#   value       = aws_subnet.public_subnet_1_vpc_tokyo.id
# }
output "private_subnet_1_vpc_tokyo_id" {
  description = "for instance"
  value       = aws_subnet.private_subnet_1_vpc_tokyo.id
}
output "private_subnet_2_vpc_tokyo_id" {
  value = aws_subnet.private_subnet_2_vpc_tokyo.id
}

output "vpc_cidr_ap-northeast-1_cidr_blocks" {
  value = aws_vpc.vpc_tokyo.cidr_block
}

output "route_private_subnet_vpc_tokyo_id" {
  value = aws_route_table.route_private_subnet_vpc_tokyo.id
}
