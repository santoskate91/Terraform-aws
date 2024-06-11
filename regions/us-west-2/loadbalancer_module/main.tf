# terraform/regions/us-west-2/loadbalancer/loadbalancer.tf

# Load Balancer
resource "aws_lb" "load_balancer_public" {
  name               = "internet-facing-alb-public"
  load_balancer_type = "application"
  internal           = false
  security_groups    = [var.aws_security_group_load_balancer_security_group_id]
  subnets            = [var.vpc_public_subnet_1_vpc_1_id, var.vpc_public_subnet_2_vpc_1_id]
}

# Target group
resource "aws_alb_target_group" "default_target_group_public" {
  name     = "app-public"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_vpc_1_id

  health_check {
    path                = var.health_check_path
    port                = "traffic-port"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 2
    interval            = 60
    matcher             = 200
  }
}

# ALB listenner
resource "aws_alb_listener" "ec2_alb_http_listener_public" {
  load_balancer_arn = aws_lb.load_balancer_public.arn
  port              = "80"
  protocol          = "HTTP"
  depends_on        = [aws_alb_target_group.default_target_group_public]

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.default_target_group_public.arn
  }
}

# ALB attachment
# resource "aws_alb_target_group_attachment" "webserver_attachment_public" {
#   for_each         = { for idx, id in var.aws_instance_bastion_list_id : idx => id }
#   target_group_arn = aws_alb_target_group.default_target_group_public.arn
#   target_id        = each.value
#   port             = 80
# }

# resource "aws_alb_target_group_attachment" "webserver_attachment_public" {
#   for_each         = { for idx, id in var.aws_instance_webserver_list_id : idx => id }
#   target_group_arn = aws_alb_target_group.default_target_group_public.arn
#   target_id        = each.value
#   port             = 80
# }
