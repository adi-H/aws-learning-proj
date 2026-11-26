resource "aws_s3_bucket" "this" {
  #checkov:skip=CKV_AWS_18:access logs need a separate log bucket - not needed for a learning project
  #checkov:skip=CKV_AWS_144:cross-region replication is for critical data, this bucket holds test files
  #checkov:skip=CKV2_AWS_62:nothing needs to react to new objects, so no event notifications
  bucket_prefix = var.bucket_prefix
}

# block every form of public access (acls and bucket policies)
resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# keep old versions of objects, so an overwrite or delete can be undone
resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = "Enabled"
  }
}

# encrypt with kms, using the free aws-managed key (aws/s3)
# bucket keys cut down the number of kms requests (and their cost)
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
    bucket_key_enabled = true
  }
}

# clean up old versions and failed uploads, so versioning doesn't keep growing the bill
resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    id     = "cleanup"
    status = "Enabled"

    filter {}

    noncurrent_version_expiration {
      noncurrent_days = 30
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }

  # versioning has to be on before lifecycle rules for old versions apply
  depends_on = [aws_s3_bucket_versioning.this]
}
