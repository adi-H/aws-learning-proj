output "bucket_arn" {
  value       = module.my-bucket.bucket_arn
  description = "my bucket arn"
}

output "bucket_name" {
  value       = module.my-bucket.bucket_name
  description = "my bucket name (id)"
}
