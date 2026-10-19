provider "aws" {
  region = "us-east-1"
}

module "my-bucket" {
  source = "../"

  bucket_prefix = "my-app-bucket-"
}
