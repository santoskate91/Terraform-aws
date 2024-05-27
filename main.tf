# terraform/main.tf

data "aws_iam_policy_document" "ec2" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "session_manager" {
  description = "session_manager"
  name        = "session_manager"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "ec2:*",
        "Effect" : "Allow",
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "elasticloadbalancing:*",
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "cloudwatch:*",
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "autoscaling:*",
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "iam:CreateServiceLinkedRole",
        "Resource" : "*"
        "Condition" : {
          "StringEquals" : {
            "iam:AWSServiceName" : [
              "autoscaling.amazonaws.com",
              "ec2scheduled.amazonaws.com",
              "elasticloadbalancing.amazonaws.com",
              "spot.amazonaws.com",
              "spotfleet.amazonaws.com",
              "transitgateway.amazonaws.com"
            ]
          }
        }
      }
    ]
  })
}

resource "aws_iam_role" "session_manager" {
  assume_role_policy = data.aws_iam_policy_document.ec2.json
  name               = "session_manager"
  tags = {
    Name = "session_manager"
  }
}

resource "aws_iam_instance_profile" "session_manager" {
  name = "session_manager"
  role = aws_iam_role.session_manager.name
}
