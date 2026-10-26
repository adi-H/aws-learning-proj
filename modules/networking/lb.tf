resource "aws_lb" "external_alb" {
  internal                         = false
  load_balancer_type               = "application"
  security_groups                  = [aws_security_group.alb_sg.id]
  subnets                          = [aws_subnet.public_1.id, aws_subnet.public_2.id]
  enable_cross_zone_load_balancing = true

  tags = { Name = "${var.environment}-alb" }
}

resource "aws_lb_target_group" "alb_tg" {
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
  load_balancer_arn = aws_lb.external_alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}

