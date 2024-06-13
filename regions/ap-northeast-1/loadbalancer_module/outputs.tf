# # terraform/regions/us-west-2/loadbalancer/outputs.tf

output "load_balancer_private_dns_name" {
  value = aws_lb.load_balancer_private.dns_name
}
