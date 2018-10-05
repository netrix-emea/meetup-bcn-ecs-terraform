# Global Aws data resources
data "aws_region" "current" {}

#https://www.terraform.io/docs/providers/aws/d/caller_identity.html
data "aws_caller_identity" "current" {}
