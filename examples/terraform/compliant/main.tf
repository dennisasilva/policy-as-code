# COMPLIANT: S3 bucket encrypted with a customer-managed KMS key (CMK).
resource "aws_kms_key" "s3" {
  description             = "CMK for S3 bucket encryption"
  enable_key_rotation     = true
  deletion_window_in_days = 7
}

resource "aws_s3_bucket" "this" {
  bucket = "pac-demo-compliant-bucket"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.s3.arn
    }
    bucket_key_enabled = true
  }
}
