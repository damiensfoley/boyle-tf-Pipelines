resource "aws_secretsmanager_secret" "aws_credentials" {
  name        = "df-aws-access-keys"
  description = "AWS access and secret key for Terraform or applications"
  tags        = local.common_tags
}

resource "aws_secretsmanager_secret_version" "aws_credentials_version" {
  secret_id     = aws_secretsmanager_secret.aws_credentials.id
  secret_string = jsonencode({
    aws_access_key_id     = var.aws_access_key
    aws_secret_access_key = var.aws_secret_key
  })
}


#IAM roles for access to secrets manager
resource "aws_iam_role" "secrets_manager_access_role" {
  name = "df-tf-secrets-manager-access-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::408468020357:role/df-tf-codebuild-pipeline-role"  # Replace with the actual principal allowed to assume this role
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "secrets_manager_access_policy" {
  name = "df-tf-secrets-manager-access-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ],
        Resource = "arn:aws:secretsmanager:${var.aws_region}:${data.aws_caller_identity.current.account_id}:secret:aws-access-keys*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_secrets_manager_policy" {
  role       = aws_iam_role.secrets_manager_access_role.name
  policy_arn = aws_iam_policy.secrets_manager_access_policy.arn
}
# Data resource to get current AWS account ID
data "aws_caller_identity" "current" {}
