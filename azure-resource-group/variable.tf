variable "location" {
  type        = string
  description = "Default Azure region where the resource groups will be created."
}

variable "tags_mandatory" {
  type        = any
  description = "Mandatory tags dictated by company policy."
}

variable "tags_additional" {
  type        = map(string)
  default     = {}
  description = "Additional optional tags."
}

variable "resource_groups" {
  description = "Map of Resource Groups to be created. The map key will be used as the Resource Group name."
  type = map(object({
    location = optional(string)
  }))
}