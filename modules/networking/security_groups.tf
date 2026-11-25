# ==========================================
# 1. CORE SECURITY GROUPS (Kept Intentionally Empty)
# ==========================================

resource "aws_security_group" "alb_sg" {
  description = "Security Group for the Internet-facing ALB"
  vpc_id      = aws_vpc.main.id

  tags = { Name = "${var.environment}-alb_sg" }
}

resource "aws_security_group" "app_sg" {
  description = "Security Group for the Backend Application"
  vpc_id      = aws_vpc.main.id

  tags = { Name = "${var.environment}-app_sg" }

}

# alb rules 
resource "aws_security_group_rule" "alb_allow_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group_rule" "alb_allow_all_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1" # -1 means all protocols
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_sg.id
}

# app rules 
resource "aws_security_group_rule" "app_allow_from_alb" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb_sg.id
  security_group_id        = aws_security_group.app_sg.id
}

resource "aws_security_group_rule" "app_allow_all_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_sg.id
}
