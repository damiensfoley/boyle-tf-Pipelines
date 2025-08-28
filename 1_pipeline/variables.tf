variable "repository_name" {
  default     = ""
  description = "CodeCommit repository name for CodePipeline builds"
}

variable "github_owner" {} 
variable "github_token" {}

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
