AWS :: IAM Role Example
=======================

Description
-----------
This is just a basic example, it represents a minimal configuration for IAM Role.


#### Change to required Terraform Version
```commandline
chtf 1.1.9
```

#### Make commands (includes local.ini support)
```commandline
make apply
make help
make plan
```

Example Outputs 
---------------
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