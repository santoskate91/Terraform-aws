# terraform/regions/ap-northeast-2/vpc_module/variaables.tf

# networking

variable "vpc_cidr_seoul" {
  description = "CIDR Block for VPC"
  default     = "12.0.0.0/16"
}
variable "private_subnet_1_cidr_seoul" {
  description = "CIDR Block for Public Subnet 1"
  default     = "12.0.1.0/24"
}
variable "private_subnet_2_cidr_seoul" {
  description = "CIDR Block for Private Subnet 1"
  default     = "12.0.3.0/24"
}
variable "availability_zones_seoul" {
  description = "Availability zones"
  type        = list(string)
  default     = ["ap-northeast-2a", "ap-northeast-2d", "ap-northeast-2c"]
}
