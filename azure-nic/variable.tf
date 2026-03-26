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

variable "nics" {
  description = "Map of Network Interfaces and their IP configurations."
  type = map(object({
    resource_group_name            = string
    dns_servers                    = optional(list(string))
    ip_forwarding_enabled          = optional(bool, false)
    accelerated_networking_enabled = optional(bool, false)
    internal_dns_name_label        = optional(string)

    network_security_group_id = optional(string)

    ip_configurations = map(object({
      subnet_id                     = optional(string)
      private_ip_address_version    = optional(string, "IPv4")
      private_ip_address_allocation = optional(string, "Dynamic")
      public_ip_address_id          = optional(string)
      private_ip_address            = optional(string)
      primary                       = optional(bool, false)
    }))
  }))
}