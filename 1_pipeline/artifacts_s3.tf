resource "aws_s3_bucket" "df-tf-artifacts" {
  bucket = "${local.prefix}-artefacts-s3"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "artifacts" {
  bucket = aws_s3_bucket.df-tf-artifacts.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_server_side_encryption_configuration" "df-tf-artifacts" {
  bucket = aws_s3_bucket.df-tf-artifacts.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }  
}


resource "aws_s3_bucket_public_access_block" "s3Public_artifacts" {
  bucket                  = aws_s3_bucket.df-tf-artifacts.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
