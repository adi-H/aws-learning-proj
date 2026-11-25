terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.61.0"
    }
  }

  required_version = ">= 1.6.0"
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Source = "https://github.com/adi-H/aws-learning-proj"
    }
  }
}
