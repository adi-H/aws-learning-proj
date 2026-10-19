output "bucket_arn" {
  value       = aws_s3_bucket.this.arn
  description = "The ARN of the created S3 bucket"
}

output "bucket_name" {
  value       = aws_s3_bucket.this.id
  description = "The name (id) of the created S3 bucket"
}
