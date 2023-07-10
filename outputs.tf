
output "apply_metadata" {
  description = "Output metadata regarding the apply."
  value = format("[%s]::[%s]::[%s]",
    data.aws_caller_identity.current.account_id,
    data.aws_caller_identity.current.arn,
    data.aws_caller_identity.current.user_id
  )
}

output  "key_attributes" {
  description = "Map of maps, indexed by they `var.keys` key, to ensure it's accessible."
  value = { 
    for key,role in var.roles : key => {
      arn = aws_iam_role.default-01[key].arn
      name = lookup(role, "name")
      attached_aws_policies = lookup(role, "attach_aws_policies")
    }    
  }
}

output  "key_resources" {
  description = "Provide full access to resource objects."
  value = {
    roles = {for key,role in var.roles : key => aws_iam_role.default-01[key]}
  }
}