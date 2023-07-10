
variable "tags" {
  description = "(Optional) Define a base set of tags to apply to every supported resource managed; you can overwrite these in each deployment configuration."
  type = map
  default = {}
}

variable "roles" {
  description = "Provide configuraiton for one or more IAM Roles."

  type = map(object({
    name                    = optional(string)
    description             = optional(string)
    max_session_duration    = optional(number)
    permissions_boundary    = optional(string)
    attach_aws_policies     = optional(list(string))
    policy_statements_for_assume_role   = list(object({
      effect          = string
      actions         = optional(list(string))
      not_actions     = optional(list(string))
      resources       = optional(list(string))
      not_resources   = optional(list(string))
      principals      = optional(list(object({
        type        = string
        identifiers = list(string)
      })))
      not_principals  = optional(list(object({
        type        = string
        identifiers = list(string)
      })))
      conditions  = optional(list(object({
        test        = string
        variable    = string
        values      = list(string)
      })))
    }))

    policy_statements   = optional(list(object({
      effect          = string
      actions         = optional(list(string))
      not_actions     = optional(list(string))
      resources       = optional(list(string))
      not_resources   = optional(list(string))
      principals      = optional(list(object({
        type        = string
        identifiers = list(string)
      })))
      not_principals  = optional(list(object({
        type        = string
        identifiers = list(string)
      })))
      conditions  = optional(list(object({
        test        = string
        variable    = string
        values      = list(string)
      })))
    })))

  }))
}
