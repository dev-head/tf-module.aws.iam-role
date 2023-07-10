
resource "aws_iam_role" "default-01" {
  for_each = var.roles 
  name = each.value["name"]
  description = each.value["description"]
  max_session_duration = each.value["max_session_duration"]
  permissions_boundary = each.value["permissions_boundary"]
  assume_role_policy = data.aws_iam_policy_document.default_roles_001_assume[each.key].json
  tags = var.tags 
}

resource "aws_iam_policy" "default-01" {
  for_each = local.iam_policies
  name = each.value["name"]
  description = each.value["description"]
  tags = var.tags
  policy = data.aws_iam_policy_document.default_roles_001__policy[each.key].json
}

resource "aws_iam_role_policy_attachment" "default" {
  for_each = local.iam_policies
  policy_arn = aws_iam_policy.default-01[each.key].id
  role = aws_iam_role.default-01[each.key].id
}

resource "aws_iam_role_policy_attachment" "role_aws_policy" {
  for_each = local.attach_aws_policies
  role = aws_iam_role.default-01[lookup(each.value, "parent_key", null)].name
  policy_arn = data.aws_iam_policy.named[lookup(each.value, "parent_key", null)].arn
}