# allow the ec2 service to use this role
data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
resource "aws_iam_role" "this" {
  name_prefix        = "ec2-s3-access-"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}

# write the permissions using the incoming bucket arn (allow this policy access to said bucket)
data "aws_iam_policy_document" "s3_access" {
  statement {
    sid       = "ListObjectsInBucket"
    actions   = ["s3:ListBucket"]
    resources = [var.target_bucket_arn] # the bucket itself
  }

  statement {
    sid       = "ReadWriteObjects"
    actions   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
    resources = ["${var.target_bucket_arn}/*"] # all objects inside
  }
}

# create an official iam policy resource
resource "aws_iam_policy" "this" {
  name   = "s3-bucket-access-policy"
  policy = data.aws_iam_policy_document.s3_access.json
}

# attach the role to the policy
resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}

# create instance-profile to allow an ec2 instance to use this role
resource "aws_iam_instance_profile" "this" {
  name = "ec2-s3-instance-profile"
  role = aws_iam_role.this.name

  depends_on = [
    aws_iam_role_policy_attachment.this
  ]
}
