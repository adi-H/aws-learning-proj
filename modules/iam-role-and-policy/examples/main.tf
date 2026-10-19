provider "aws" {
  region = "us-east-1"
}

module "my-bucket" {
  source = "../../s3-bucket"

  bucket_prefix = "my-app-bucket-"
}

module "my-iam-role-policy" {
  source = "../"

  target_bucket_arn = module.my-bucket.bucket_arn
}
