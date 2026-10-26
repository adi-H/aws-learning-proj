output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_1_subnet_id" {
  value = aws_subnet.public_1.id
}

output "public_2_subnet_id" {
  value = aws_subnet.public_2.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "vpc_cidr" {
  value = aws_vpc.main.cidr_block
}

output "alb_dns_name" {
  value = aws_lb.external_alb.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.alb_tg.arn
}

output "app_sg_id" {
  value = aws_security_group.app_sg.id
}
