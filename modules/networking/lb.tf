resource "aws_lb" "external_alb" {
  #checkov:skip=CKV_AWS_150:deletion protection would block terraform destroy, which runs after every session to save costs
  #checkov:skip=CKV_AWS_91:access logs need a log bucket with an elb bucket policy - planned with the monitoring work
  #checkov:skip=CKV2_AWS_20:no domain, so no certificate for an https listener to redirect to
  #checkov:skip=CKV2_AWS_28:waf costs ~$5+/month, not worth it for a learning project serving a static page
  internal                         = false
  load_balancer_type               = "application"
  security_groups                  = [aws_security_group.alb_sg.id]
  subnets                          = [aws_subnet.public_1.id, aws_subnet.public_2.id]
  enable_cross_zone_load_balancing = true
  drop_invalid_header_fields       = true # protects against http request smuggling

  tags = { Name = "${var.environment}-alb" }
}

resource "aws_lb_target_group" "alb_tg" {
  #checkov:skip=CKV_AWS_378:tls ends at the alb (standard setup), traffic to the instance stays inside the private vpc
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "instance"

  tags = { Name = "${var.environment}-alb_tg" }

  health_check {
    path                = "/"
    port                = "80"
    protocol            = "HTTP"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200" # Strict production check: Only green if Apache answers perfectly!
  }
}

resource "aws_lb_listener" "http" {
  #checkov:skip=CKV_AWS_2:no domain, so no certificate for https yet
  #checkov:skip=CKV_AWS_103:tls policy only applies to https listeners - see CKV_AWS_2
  load_balancer_arn = aws_lb.external_alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}

