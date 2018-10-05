# Global Aws data resources
data "aws_region" "current" {}

#https://www.terraform.io/docs/providers/aws/d/caller_identity.html
data "aws_caller_identity" "current" {}

// retrieve Default VPC information
data "aws_vpc" "default" {
  default = true
}

// retreive subnets-ids for default VPC
data "aws_subnet_ids" "default" {
  vpc_id = "${data.aws_vpc.default.id}"
}

// retreive subnets for default VPC
data "aws_subnet" "default" {
  count = "${length(data.aws_subnet_ids.default.ids)}"
  id    = "${data.aws_subnet_ids.default.ids[count.index]}"
}

provider "aws" {
  #  region  = "${data.aws_region.current.name}"
  version = "~> 1.36"
}

# If the running Terraform version doesn't meet these constraints,
# an error is shown
terraform {
  required_version = ">= 0.11.4"

  #  backend          "s3"             {}
}

# Is created by the gui when start to use. Required with  empty account and first  run
# resource "aws_iam_service_linked_role" "ecs" {
#   aws_service_name = "ecs.amazonaws.com"
# }

