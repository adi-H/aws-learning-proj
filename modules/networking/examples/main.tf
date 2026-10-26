provider "aws" {
  region = "us-east-1"
}

module "networking" {
  source = "../"
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
