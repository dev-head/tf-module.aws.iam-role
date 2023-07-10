AWS :: IAM Role
===============

Description
-----------
This module provides the ability to define one or more IAM Roles through a uniform configuration.

Example
-------
> [Example Module](./example/default) found in `./example/default`

      
Usage :: Defined Variables
--------------------------- 
```hcl-terraform

module "iam-roles" {
  source = "git@github.com:dev-head/tf-module.aws.iam-role.git?ref=0.0.1"

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
  }
}
```

Outputs 
-------
| key               | type      | Description 
|:-----------------:|:---------:| ------------------------------------------------------------------------------------:| 
| apply_metadata    | string    | Output metadata regarding the apply.
| key_attributes    | object    | Map of maps, indexed by they `var.keys` key, to ensure it's accessible.
| key_resources     | object    | Provide full access to resource objects.

#### Example 
```
key_attributes = {
  "example_01" = {
    "arn" = "arn:aws:iam::555555555555:role/example-role-01"
    "attached_aws_policies" = tolist([
      "AmazonS3ReadOnlyAccess",
    ])
    "name" = "example-role-01"
  }
  "example_02" = {
    "arn" = "arn:aws:iam::555555555555:role/example-role-02"
    "attached_aws_policies" = tolist([
      "AmazonEKSClusterPolicy",
    ])
    "name" = "example-role-02"
  }
}
```

Deployment 
----------
> Update the `CHANGELOG.md` please.

```
git tag -l
git tag -a 0.0.1
git show 0.0.1
git push origin 0.0.1
```
