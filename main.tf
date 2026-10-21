module "my-bucket-1" {
  source = "./modules/s3-bucket"

  bucket_prefix = "my-nginx-bucket-"
}

module "ec2-access-to-my-bucket" {
  source            = "./modules/iam-role-and-policy"
  target_bucket_arn = module.my-bucket-1.bucket_arn
}

module "nginx-vm" {
  source = "./modules/ec2"

  sg_name = "nginx-vm-sg"
  vm_name = "nginx-vm"

  tags = { env = "dev", service = "nginx" }

  instance_profile_name = module.ec2-access-to-my-bucket.instance_profile_name

  user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello World from EC2 deployed via Terraform!</h1>" > /var/www/html/index.html
              EOF

  depends_on = [module.ec2-access-to-my-bucket]
}

# adding http only to nginx vm
resource "aws_security_group_rule" "web_http_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.nginx-vm.security_group_id # Links to the web server SG
  depends_on        = [module.nginx-vm]
}
