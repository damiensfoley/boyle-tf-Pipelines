<<<<<<< HEAD
output "dynamodb-lock-table" {
    value = aws_dynamodb_table.lock_table.name
    description = "DynamoDB table for Terraform execution locks"
}

output "dynamodb-lock-table-ssm-parameter" {
    value = "${local.ssm_prefix}/df-tf-locks-table-arn"
    description = "SSM parameter containing DynamoDB table for Terraform execution locks"
}

output "s3-state-bucket" {
    value = aws_s3_bucket.remote_state.id
    description = "S3 bucket for storing Terraform state"
}

output "s3-state-bucket-ssm-parameter" {
    value = "${local.ssm_prefix}/df-tf-remote-state-bucket"
    description = "SSM parameter containing S3 bucket for storing Terraform state"
}
=======
output "dynamodb-lock-table" {
    value = aws_dynamodb_table.lock_table.name
    description = "DynamoDB table for Terraform execution locks"
}

output "dynamodb-lock-table-ssm-parameter" {
    value = "${local.ssm_prefix}/df-tf-locks-table-arn"
    description = "SSM parameter containing DynamoDB table for Terraform execution locks"
}

output "s3-state-bucket" {
    value = aws_s3_bucket.df-terraform-remote-state-s3.id
    description = "S3 bucket for storing Terraform state"
}

output "s3-state-bucket-ssm-parameter" {
    value = "${local.ssm_prefix}/df-tf-remote-state-bucket"
    description = "SSM parameter containing S3 bucket for storing Terraform state"
}


>>>>>>> a0f44d0591a2dec80898715bdb60e39940eb56b5
