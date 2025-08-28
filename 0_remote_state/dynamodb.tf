<<<<<<< HEAD
resource "aws_dynamodb_table" "lock_table" {
  name           = "${local.prefix}-dynamodb"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"
  tags           = local.common_tags

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_ssm_parameter" "locks_table_arn" {
  name  = "${local.ssm_prefix}/df-tf-locks-table-arn"
  type  = "String"
  value = aws_dynamodb_table.lock_table.arn
}
=======
resource "aws_dynamodb_table" "lock_table" {
  name           = "${local.prefix}-dynamodb"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"
  tags           = local.common_tags

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_ssm_parameter" "locks_table_arn" {
  name  = "${local.ssm_prefix}/df-tf-locks-table-arn"
  type  = "String"
  value = aws_dynamodb_table.lock_table.arn
}
>>>>>>> a0f44d0591a2dec80898715bdb60e39940eb56b5
