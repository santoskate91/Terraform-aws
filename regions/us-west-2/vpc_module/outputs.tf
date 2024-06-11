# terraform/regions/us-west-2/vpc_module/outputs.tf

output "vpc_1_id" {
  description = "VPC for security group"
  value       = aws_vpc.vpc_1.id
}

output "public_subnet_1_vpc_1_id" {
  description = "public subnet for instance"
  value       = aws_subnet.public_sebnet_1_vpc_1.id
}
output "public_subnet_2_vpc_1_id" {
  description = "public subnet for instance"
  value       = aws_subnet.public_subnet_2_vpc_1.id
}

output "private_subnet_1_vpc_1_id" {
  description = "public subnet for instance"
  value       = aws_subnet.private_subnet_1_vpc_1.id
}
output "private_subnet_2_vpc_1_id" {
  description = "public subnet for instance"
  value       = aws_subnet.private_subnet_2_vpc_1.id
}
# output "natgw_vpc_1" {
#   value = aws_nat_gateway.natgw_vpc_1
# }

# output "vpc_2_id" {
#   description = "VPC for security group"
#   value       = aws_vpc.vpc_2.id
# }

# output "public_subnet_1_vpc_2_id" {
#   description = "for instance"
#   value       = aws_subnet.public_subnet_1_vpc_2.id
# }
# output "private_subnet_1_vpc_2_id" {
#   description = "for instance"
#   value       = aws_subnet.private_subnet_1_vpc_2.id
# }

# transits
output "vpc_cidr_us-west-2" {
  value = aws_vpc.vpc_1.cidr_block
}
output "route_private_subnet_vpc_1_id" {
  value = aws_route_table.route_private_subnet_vpc_1.id
}
