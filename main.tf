module "nginx-vm" {
  source = "./modules/ec2"

  sg_name = "nginx-vm-sg"
  vm_name = "nginx-vm"

  tags = { env = "dev", service = "nginx" }

  user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello World from EC2 deployed via Terraform!</h1>" > /var/www/html/index.html
              EOF
}

# adding http only to nginx vm
resource "aws_security_group_rule" "web_http_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.nginx-vm.security_group_id # Links to the web server SG
}
