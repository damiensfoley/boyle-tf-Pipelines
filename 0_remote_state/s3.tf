<<<<<<< HEAD
resource "aws_kms_key" "tfbucket" {
  description             = "Encryption key for Terraform s3 bucket."
  deletion_window_in_days = 7
  enable_key_rotation     = true
  # tags = var.tags
}

resource "aws_s3_bucket" "remote_state" {
  bucket        = "${local.prefix}-s3"
  force_destroy = true
}

# resource "aws_s3_bucket_acl" "tfbucket_acl" {
#   bucket = aws_s3_bucket.remote_state.id
#   acl    = "private"

#   depends_on = [aws_s3_bucket.remote_state]
# }

resource "aws_s3_bucket_versioning" "tfversioning" {
  bucket = aws_s3_bucket.remote_state.id

  versioning_configuration {
    status = "Enabled"
  }

  depends_on = [aws_s3_bucket.remote_state]
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tfbucket" {
  depends_on = [aws_kms_key.tfbucket, aws_s3_bucket.remote_state]
  bucket     = aws_s3_bucket.remote_state.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.tfbucket.arn
      sse_algorithm     = "aws:kms"
    }
  }

  lifecycle {
    prevent_destroy = false
  }

  # tags = local.common_tags
}

resource "aws_s3_bucket_public_access_block" "s3Public_remote_state" {
  bucket                  = aws_s3_bucket.remote_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  depends_on = [aws_s3_bucket.remote_state]
}

resource "aws_s3_bucket_policy" "remote_state" {
  bucket = aws_s3_bucket.remote_state.id

  depends_on = [aws_s3_bucket.remote_state]

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowTerraformUserAccessToStateFiles",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::408468020357:user/diosfcli"
      },
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject"
      ],
      "Resource": [
        "${aws_s3_bucket.remote_state.arn}/*"
      ]
    },
    {
      "Sid": "DenyInsecureAccess",
      "Effect": "Deny",
      "NotPrincipal": {
        "AWS": "arn:aws:iam::408468020357:user/diosfcli"
      },
      "Action": "s3:*",
      "Resource": [
        "${aws_s3_bucket.remote_state.arn}",
        "${aws_s3_bucket.remote_state.arn}/*"
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
      "NotPrincipal": {
        "AWS": "arn:aws:iam::408468020357:user/diosfcli"
      },
      "Action": "s3:PutObject",
      "Resource": [
        "${aws_s3_bucket.remote_state.arn}/*"
      ],
      "Condition": {
        "StringNotEquals": {
          "s3:x-amz-server-side-encryption": "aws:kms"
        }
      }
    },
    {
      "Sid": "DenyUnencryptedObjectUploads",
      "Effect": "Deny",
      "NotPrincipal": {
        "AWS": "arn:aws:iam::408468020357:user/diosfcli"
      },
      "Action": "s3:PutObject",
      "Resource": [
        "${aws_s3_bucket.remote_state.arn}/*"
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

resource "aws_ssm_parameter" "remote_state_bucket" {
  name  = "${local.ssm_prefix}/df-tf-remote-state-bucket"
  type  = "String"
  value = aws_s3_bucket.remote_state.id
  tags  = local.common_tags
}
=======
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
>>>>>>> a0f44d0591a2dec80898715bdb60e39940eb56b5
