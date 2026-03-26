variable "location" {
  type        = string
  description = "Azure region where the Virtual Machines will be deployed."
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

variable "vms" {
  description = "Map of Windows Virtual Machines to be created."
  type = map(object({
    resource_group_name   = string
    size                  = string
    admin_username        = string
    admin_password        = string
    network_interface_ids = list(string)

    os_disk = optional(object({
      caching              = optional(string, "ReadWrite")
      storage_account_type = optional(string, "Standard_LRS")
      disk_size_gb         = optional(number, 128)
    }), {})

    source_image_reference = optional(object({
      publisher = optional(string, "MicrosoftWindowsServer")
      offer     = optional(string, "WindowsServer")
      sku       = optional(string, "2022-Datacenter")
      version   = optional(string, "latest")
    }), {})
  }))
}