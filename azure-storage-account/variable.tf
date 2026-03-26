variable "location" {
  type        = string
  description = "Azure region where the storage accounts will be deployed."
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

variable "storage_accounts" {
  description = "Map of Storage Accounts to be created with their network rules and blob properties."
  type = map(object({
    resource_group_name           = string
    account_tier                  = optional(string, "Standard")
    account_replication_type      = optional(string, "LRS")
    public_network_access_enabled = optional(bool, false)
    shared_access_key_enabled     = optional(bool, true)

    network_rules = optional(object({
      default_action             = optional(string, "Deny")
      bypass                     = optional(list(string), ["AzureServices"])
      ip_rules                   = optional(list(string), [])
      virtual_network_subnet_ids = optional(list(string), [])
    }))

    blob_properties = optional(object({
      versioning_enabled    = optional(bool, false)
      delete_retention_days = optional(number, 7)
    }))
  }))
}