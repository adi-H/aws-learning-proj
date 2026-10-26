output "vpc_id" {
  value = module.networking.vpc_id
}

output "alb_dns_name" {
  value = module.networking.alb_dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.alb_tg.arn
}
