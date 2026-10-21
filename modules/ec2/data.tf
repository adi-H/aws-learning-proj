
# fetch latest amazon linux ami 
data "aws_ami" "amazon_linux" {

  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

locals {
  ami_id = data.aws_ami.amazon_linux.id
}

data "aws_vpc" "selected" {
  id      = var.vpc_id
  default = var.vpc_id == null ? true : null
}

data "aws_subnets" "fallback" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}

# if a subnet id is passed, use it; otherwise, use the first subnet that the vpc_id fallback gives
data "aws_subnet" "selected" {
  id = var.subnet_id != null ? var.subnet_id : data.aws_subnets.fallback.ids[0]
}
