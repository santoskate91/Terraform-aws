# terraform/regions/ap-northeast-1/keypair_module/outputs.tf

output "generated_key_keyname" {
  description = "Key pair for EC2"
  value       = aws_key_pair.generated_key.key_name
}
output "generated_key" {
  description = "Key pair for EC2"
  value       = aws_key_pair.generated_key
}
