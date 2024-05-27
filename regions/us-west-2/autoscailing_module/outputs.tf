# terraform/autoscailing_module/outputs.tf

output "aws_autoscaling_group_ec2_cluster_id" {
  value = aws_autoscaling_group.ec2-ec2_cluster.id
}
