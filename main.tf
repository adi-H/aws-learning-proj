module "networking" {
  source = "./modules/networking"
  public_1_subnet = {
    cidr_block = "10.0.1.0/24"
  }
  public_2_subnet = {
    cidr_block = "10.0.2.0/24"
  }
  private_subnet = {
    cidr_block = "10.0.3.0/24"
  }

  vpc_cidr    = "10.0.0.0/16"
  environment = "dev"
}

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

  environment = "dev"
  vpc_id      = module.networking.vpc_id
  subnet_id   = module.networking.private_subnet_id

  tags = { env = "dev", service = "nginx" }

  additional_policy_arns       = [module.ec2-access-to-my-bucket.iam_policy_arn]
  networking_security_group_id = module.networking.app_sg_id

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

resource "aws_lb_target_group_attachment" "web_app" {
  target_group_arn = module.networking.target_group_arn
  target_id        = module.nginx-vm.instance_id
  port             = 80
}
# # adding http only to nginx vm
# resource "aws_security_group_rule" "web_http_ingress" {
#   type              = "ingress"
#   from_port         = 80
#   to_port           = 80
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = module.nginx-vm.security_group_id # Links to the web server SG
#   depends_on        = [module.nginx-vm]
# }
