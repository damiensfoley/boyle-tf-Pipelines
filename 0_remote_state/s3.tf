resource "aws_s3_bucket" "df-terraform-remote-state-s3" {
  bucket = "df-terraform-remote-state-s3"
  force_destroy = true
}

# resource "aws_s3_bucket_acl" "df-terraform-remote-state-s3" {
#   bucket = aws_s3_bucket.df-terraform-remote-state-s3.id
#   acl    = "private"
# }

# resource "aws_s3_bucket_object" "df-terraform-remote-state-s3" {
#   key        = "someobject"
#   bucket     = aws_s3_bucket.examplebucket.id
#   source     = "index.html"
#   kms_key_id = aws_kms_key.examplekms.arn
# }

resource "aws_s3_bucket_versioning" "df-terraform-remote-state-s3" {
  bucket = aws_s3_bucket.df-terraform-remote-state-s3.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "df-terraform-remote-state-s3" {
  bucket = aws_s3_bucket.df-terraform-remote-state-s3.bucket

  rule {
    apply_server_side_encryption_by_default {
      # kms_master_key_id = aws_kms_key.df-terraform-remote-state-s3.arn
      sse_algorithm     = "AES256"
    }
  }  
}
  # lifecycle {
  #   prevent_destroy = false
  # }

  /* tags = local.common_tags */
# }

resource "aws_s3_bucket_public_access_block" "df-terraform-remote-state-s3_block" {
  bucket                  = aws_s3_bucket.df-terraform-remote-state-s3.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "remote-state" {
  bucket = aws_s3_bucket.df-terraform-remote-state-s3.id

  policy = <<POLICY
{
    "Version": "2008-10-17",
    "Statement": [
        {
          "Sid": "DenyInsecureAccess",
          "Effect": "Deny",
          "Principal": "*",
          "Action": "s3:*",
          "Resource": [
            "arn:aws:s3:::df-terraform-remote-state-s3",
            "arn:aws:s3:::df-terraform-remote-state-s3/*"
          ],
          "Condition": {
            "Bool": {
              "aws:SecureTransport": "false"
            }
          }
        },
        {
          "Sid": "EnforceEncryption",
          "Effect": "Deny",
          "Principal": "*",
          "Action": "s3:PutObject",
          "Resource": [
            "arn:aws:s3:::df-terraform-remote-state-s3/*"
          ],
          "Condition": {
            "StringNotEquals": {
              "s3:x-amz-server-side-encryption": "AES256"
            }
          }
        },
        {
          "Sid": "DenyUnencryptedObjectUploads",
          "Effect": "Deny",
          "Principal": "*",
          "Action": "s3:PutObject",
          "Resource": [
            "arn:aws:s3:::df-terraform-remote-state-s3/*"
          ],
          "Condition": {
            "Null": {
              "s3:x-amz-server-side-encryption": "true"
            }
          }
        }
    ]
}
POLICY

}
resource "aws_ssm_parameter" "df-terraform-remote-state-s3" {
  name  = "${local.ssm_prefix}/df-tf-remote-state-bucket"
  type  = "String"
  value = aws_s3_bucket.df-terraform-remote-state-s3.id
}
