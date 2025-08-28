# CodeBuild


resource "aws_codebuild_project" "tf_destroy" {
  name         = "${local.prefix}-tf-destroy"
  description  = "Managed using Terraform"
  service_role = aws_iam_role.codebuild.arn
  tags         = local.common_tags

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:5.0"
    type         = "LINUX_CONTAINER"
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec-destroy.yml"
  }
}
