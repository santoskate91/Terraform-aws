# terraform/regions/ap-northeast-1/vpc_module/outputs.tf

output "vpc_tokyo" {
  description = "VPC for security group"
  value       = aws_vpc.vpc_tokyo.id
}

output "public_subnet_1_vpc_tokyo" {
  description = "for instance"
  value       = aws_subnet.public_subnet_1_vpc_tokyo.id
}
output "private_subnet_1_vpc_tokyo" {
  description = "for instance"
  value       = aws_subnet.private_subnet_1_vcp_2.id
}
