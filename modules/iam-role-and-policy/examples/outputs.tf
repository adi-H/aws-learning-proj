output "instance_profile_name" {
  value       = module.my-iam-role-policy.instance_profile_name
  description = "The name of the instance profile to pass directly to your EC2 instance module"
}

