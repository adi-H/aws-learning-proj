provider "aws" {
  region = "us-east-1"
}

module "nginx-vm" {
  source = "../"

  sg_name = "nginx-vm-sg"
  vm_name = "nginx-vm"

  tags = { env = "dev", service = "nginx" }

  user_data = ""
}
