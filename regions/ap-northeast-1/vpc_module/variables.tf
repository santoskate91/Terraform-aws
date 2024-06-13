# terraform/regions/ap-northeast-1/vpc_module/variables.tf

# networking

variable "vpc_cidr_tokyo" {
  description = "CIDR Block for VPC"
  default     = "11.0.0.0/16"
}
variable "public_subnet_1_cidr_tokyo" {
  description = "CIDR Block for Public Subnet 1"
  default     = "11.0.1.0/24"
}
variable "private_subnet_1_cidr_tokyo" {
  description = "CIDR Block for Private Subnet 1"
  default     = "11.0.2.0/24"
}
variable "private_subnet_2_cidr_tokyo" {
  description = "CIDR Block for Private Subnet 1"
  default     = "11.0.3.0/24"
}
variable "availability_zones_tokyo" {
  description = "Availability zones"
  type        = list(string)
  default     = ["ap-northeast-1a", "ap-northeast-1d", "ap-northeast-1c"]
}


