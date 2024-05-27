# terraform/regions/ap-northeast-1/keypair_module/main.tf

# For EC2 key pair
resource "tls_private_key" "ec2key_tokyo" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "generated_key_tokyo" {
  key_name   = "ec2key"
  public_key = tls_private_key.ec2key.public_key_openssh
  depends_on = [
    tls_private_key.ec2key_tokyo
  ]
}
resource "local_file" "key_tokyo" {
  content         = tls_private_key.ec2key.private_key_pem
  filename        = "ec2key_tokyo.pem"
  file_permission = "0400"
  depends_on = [
    tls_private_key.ec2key_tokyo
  ]
}
