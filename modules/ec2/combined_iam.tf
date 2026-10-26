resource "aws_iam_role" "combined_role" {
  tags = { Name = "${var.environment}-ec2_combined_role" }

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "://amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.combined_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "extra_policies" {
  for_each   = toset(var.additional_policy_arns)
  role       = aws_iam_role.combined_role.name
  policy_arn = each.value
}

resource "aws_iam_instance_profile" "final_profile" {
  name = "learning-ec2-final-profile"
  role = aws_iam_role.combined_role.name
}
