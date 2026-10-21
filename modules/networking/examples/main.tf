provider "aws" {
  region = "us-east-1"
}

module "network" {
  source             = "../"
  vpc_cidr           = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  environment        = "learning"
}
