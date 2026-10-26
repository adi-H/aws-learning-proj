provider "aws" {
  region = "us-east-1"
}

variables {
  vpc_cidr           = "10.99.0.0/16"
    public_1_subnet = {
    cidr_block = "10.99.1.0/24"
  }
  public_2_subnet = {
    cidr_block = "10.99.2.0/24"
  }
  private_subnet = {
    cidr_block = "10.99.3.0/24"
  }
  environment        = "ci-test"
}

run "apply_and_verify_outputs" {
  command = apply

  # FORCE the test framework to look straight at the module, bypassing root quirks
  module {
    source = "./modules/networking"
  }

  assert {
    condition     = output.vpc_cidr == "10.99.0.0/16" # Note: use 'output.' when scoped directly to a module
    error_message = "VPC CIDR block doesn't match."
  }

  assert {
    condition     = can(regex("^vpc-", output.vpc_id))
    error_message = "The outputted VPC ID format is invalid."
  }
}
