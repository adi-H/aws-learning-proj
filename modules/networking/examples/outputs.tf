output "vpc_id" {
  value = module.networking.vpc_id
}

output "alb_dns_name" {
  value = module.networking.alb_dns_name
}

output "target_group_arn" {
  value = module.networking.target_group_arn
}
