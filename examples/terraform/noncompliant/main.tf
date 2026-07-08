# NON-COMPLIANT: SSE-S3 (AES256) instead of a customer-managed KMS key (CMK).
# This must be flagged by policy CKV2_PAC_1.
resource "aws_s3_bucket" "this" {
  bucket = "pac-demo-noncompliant-bucket"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
