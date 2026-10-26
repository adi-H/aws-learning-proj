output "instance_profile_name" {
  value       = aws_iam_instance_profile.this.name
  description = "The name of the instance profile to pass directly to your EC2 instance module"
}

output "instance_profile_arn" {
  value       = aws_iam_instance_profile.this.arn
  description = "The ARN of the instance profile to pass directly to your EC2 instance module"
}
