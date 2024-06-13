# terraform/regions/ap-northeast-2/launchconfigurations.tf

# S3 for log from us-west-2
resource "aws_s3_bucket" "trail_logs" {
  bucket        = "ap-northeast-2-trail-logs"
  force_destroy = true

}
resource "aws_s3_bucket_policy" "cloudtrail_bucket_policy" {
  bucket = aws_s3_bucket.trail_logs.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "cloudtrail.amazonaws.com"
        },
        "Action" : "s3:GetBucketAcl",
        "Resource" : "${aws_s3_bucket.trail_logs.arn}"
      },
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "cloudtrail.amazonaws.com"
        },
        "Action" : "s3:PutObject",
        "Resource" : "${aws_s3_bucket.trail_logs.arn}/*",
        "Condition" : {
          "StringEquals" : {
            "s3:x-amz-acl" : "bucket-owner-full-control"
          }
        }
      }
    ]
  })

  depends_on = [aws_s3_bucket.trail_logs]
}
