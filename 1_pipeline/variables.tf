<<<<<<< HEAD
variable "repository_name" {
  default = "df-tf-project"
  description = "CodeCommit repository name for CodePipeline builds"
}

variable "listen_branch_name" {
  default = "master"
  description = "CodeCommit branch name for CodePipeline builds"
}
variable "aws_region" {}
variable "aws_secret_key" {}
variable "aws_access_key" {}
=======
variable "network_repository_name" {
  default     = ""
  description = "CodeCommit repository name for CodePipeline builds"
}

variable "rds_repository_name" {
  default     = ""
  description = "CodeCommit repository name for CodePipeline builds"
}

variable "listen_branch_name" {
  default     = "main"
  description = "CodeCommit branch name for CodePipeline builds"
}

variable "aws_region" {}
variable "aws_secret_key" {}
# variable "aws_session_token" {}
variable "aws_access_key" {}

variable "infracost_key_api" {
  default=""
}
variable ConnectionArn {
  default=""
}
variable service_name {
  default=""
}
>>>>>>> a0f44d0591a2dec80898715bdb60e39940eb56b5
