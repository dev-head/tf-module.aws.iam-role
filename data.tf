locals {
    attach_aws_policies_list   = flatten([
        for key,role in var.roles : [
            for policy in (role["attach_aws_policies"] == null? [] : role["attach_aws_policies"]):
                { parent_key  = key, name = policy }
        ]
    ])
    attach_aws_policies = { for item in local.attach_aws_policies_list : item.parent_key => item  }

    iam_policies = { 
      for key,role in var.roles : key => role if role["policy_statements"] != null
    }
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_iam_policy" "named" {
  for_each = local.attach_aws_policies 
  name = lookup(each.value, "name", null)
}

data "aws_iam_policy_document" "default_roles_001_assume" {
  for_each = var.roles

  dynamic "statement" {
    for_each = each.value["policy_statements_for_assume_role"] == null? [] : each.value["policy_statements_for_assume_role"]

    content {
      actions = lookup(statement.value, "actions", null)
      not_actions = lookup(statement.value, "not_actions", null)
      effect = lookup(statement.value, "effect", null)
      resources = lookup(statement.value, "resources", null)
      not_resources = lookup(statement.value, "not_resources", null)

      dynamic "condition" {
        for_each = statement.value["conditions"] == null? [] : statement.value["conditions"]
        content {
          test = lookup(condition.value, "test", null)
          variable = lookup(condition.value, "variable", null)
          values = lookup(condition.value, "values", null)
        }
      }

      dynamic "principals" {
        for_each = statement.value["principals"] == null? [] : statement.value["principals"]
        content {
          type = lookup(principals.value, "type", null)
          identifiers = lookup(principals.value, "identifiers", null)
        }
      }

      dynamic "not_principals" {
        for_each = statement.value["not_principals"] == null? [] : statement.value["not_principals"]
        content {
          type = lookup(not_principals.value, "type", null)
          identifiers = lookup(not_principals.value, "identifiers", null)
        }
      }
    }
  }
}

data "aws_iam_policy_document" "default_roles_001__policy" {
  for_each = local.iam_policies

  dynamic "statement" {
    for_each = each.value["policy_statements"] == null? [] : each.value["policy_statements"]
    content {
      actions = lookup(statement.value, "actions", null)
      not_actions = lookup(statement.value, "not_actions", null)
      effect = lookup(statement.value, "effect", null)
      resources = lookup(statement.value, "resources", null)
      not_resources = lookup(statement.value, "not_resources", null)

      dynamic "condition" {
        for_each = statement.value["conditions"] == null? [] : statement.value["conditions"]
                
        content {
          test = lookup(condition.value, "test", null)
          variable = lookup(condition.value, "variable", null)
          values = lookup(condition.value, "values", null)
        }
      }

      dynamic "principals" {
        for_each = statement.value["principals"] == null? [] : statement.value["principals"]
        content {
          type = lookup(principals.value, "type", null)
          identifiers = lookup(principals.value, "identifiers", null)
        }
      }

      dynamic "not_principals" {
        for_each = statement.value["not_principals"] == null? [] : statement.value["not_principals"]
        content {
          type = lookup(not_principals.value, "type", null)
          identifiers = lookup(not_principals.value, "identifiers", null)
        }
      }
    }
  }
}