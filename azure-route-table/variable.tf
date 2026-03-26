variable "location" {
  type        = string
  description = "Azure region where the resources will be deployed."
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

variable "route_tables" {
  description = "Map of Route Tables, their routes, and associated subnets."
  type = map(object({
    resource_group_name           = string
    bgp_route_propagation_enabled = optional(bool, true)

    routes = optional(map(object({
      address_prefix         = string
      next_hop_type          = string
      next_hop_in_ip_address = optional(string)
    })), {})

    subnet_ids = optional(map(string), {})
  }))
}