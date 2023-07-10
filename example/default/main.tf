#------------------------------------------------------------------------------#
# @title: Terraform Example
# @description: Used to test and provide a working example for this module.
#------------------------------------------------------------------------------#

terraform {
  required_version = "~> 1.1.9"
  experiments = [module_variable_optional_attrs]  
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

variable "aws_region" {
  description = "(Optional) AWS region for this to be applied to. (Default: 'us-east-1')"
  type        = string
  default     = "us-west-2"
}

variable "aws_profile" {
  description = "(Optional) Provider AWS profile name for local aws cli configuration. (Default: '')"
  type        = string
  default     = ""
}

module "example" {
  source = "../../"
  tags = {
     ManagedBy = "Terraform"
  }
  roles = {
    example_01 = {
      name = "example-role-01"
      description = "Managed role for [misc]::[example-role-01]"
      attach_aws_policies = ["AmazonS3ReadOnlyAccess"]
      policy_statements_for_assume_role = [
        {
          effect = "Allow"
          actions = ["sts:AssumeRole"]
          principals = [{ type = "Service", identifiers = ["firehose.amazonaws.com"]}]
        }
      ]
    }
    example_02 = {
      name = "example-role-02"
      description = "Managed role for [eks]::[example-role-02]"
      attach_aws_policies = ["AmazonEKSClusterPolicy"]
      policy_statements_for_assume_role   = [
        {
          effect = "Allow"
          actions = ["sts:AssumeRole"]
          principals = [{type = "Service",  identifiers = ["eks.amazonaws.com"]}]
          conditions  = []
          not_actions  = [], not_principals  = [], resources = [], not_resources = []
        }
      ]
      
      policy_statements   = [
        {
          effect          = "Allow"
          actions         = ["iam:PassRole"]
          resources       = ["*"]
        }
      ]
    }
  }
}

output "metadata" {
    description = "Output metadata regarding the apply."
    value       = module.example.apply_metadata
}

output "key_attributes" {
    description = "Output key attributes from this module."
    value       = module.example.key_attributes
}
