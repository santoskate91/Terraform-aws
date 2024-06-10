# terraform/regions/ap-northeast-2/securitygroups.tf

# Instance Security grop (Traffic ALB -> EC2, ssh -> EC2)
resource "aws_security_group" "ec2_security_group_seoul" {
  name        = "ec2_security_group"
  description = "Allow inbound access from the ALB only"
  vpc_id      = module.vpc.vpc_seoul

  # ingress {
  #   from_port       = 0
  #   to_port         = 0
  #   protocol        = "-1"
  #   security_groups = [aws_security_group.load_balancer_security_group.id]
  # }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "ICMP - ping"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2_security_group"
  }
}
