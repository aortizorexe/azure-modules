variable "location" {
  type        = string
  description = "Azure region where the Virtual Networks will be deployed."
}

variable "tags_mandatory" {
  type        = any
  description = "Mandatory tags dictated by standard cloud governance."
}

variable "tags_additional" {
  type        = map(string)
  default     = {}
  description = "Additional optional tags."
}

variable "vnets" {
  description = "Map of Virtual Networks and their nested Subnets."
  type = map(object({
    resource_group_name = string
    address_space       = list(string)
    dns_servers         = optional(list(string))

    subnets = optional(map(object({
      address_prefixes  = list(string)
      service_endpoints = optional(list(string))
      delegation = optional(map(object({
        name_service_delegation = string
        actions                 = optional(list(string))
      })))
    })))
  }))
}