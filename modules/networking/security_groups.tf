# ==========================================
# 1. CORE SECURITY GROUPS (Kept Intentionally Empty)
# ==========================================

resource "aws_security_group" "alb_sg" {
  description = "Security Group for the Internet-facing ALB"
  vpc_id      = aws_vpc.main.id

  tags = { Name = "${var.environment}-alb_sg" }
}

resource "aws_security_group" "app_sg" {
  #checkov:skip=CKV2_AWS_5:false positive - attached to the ec2 instance in the root main.tf (additional_security_group_ids)
  description = "Security Group for the Backend Application"
  vpc_id      = aws_vpc.main.id

  tags = { Name = "${var.environment}-app_sg" }

}

# alb rules 
resource "aws_security_group_rule" "alb_allow_http" {
  #checkov:skip=CKV_AWS_260:internet-facing load balancer - accepting http from everyone is its job
  description       = "allow http from the internet"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_sg.id
}

# the alb only needs to reach the app servers (traffic + health checks), not the whole internet
resource "aws_security_group_rule" "alb_egress_to_app" {
  description              = "allow http to the app servers only"
  type                     = "egress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.app_sg.id # for egress rules, this is the destination
  security_group_id        = aws_security_group.alb_sg.id
}

# app rules 
resource "aws_security_group_rule" "app_allow_from_alb" {
  description              = "allow http from the alb only"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb_sg.id
  security_group_id        = aws_security_group.app_sg.id
}

resource "aws_security_group_rule" "app_allow_all_egress" {
  #checkov:skip=CKV_AWS_382:the app needs outbound internet through the nat gateway (dnf packages, ssm)
  description       = "allow all outbound traffic (through the nat gateway)"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_sg.id
}
