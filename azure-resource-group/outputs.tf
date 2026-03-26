output "resource_group_ids" {
  description = "Map containing the IDs of the created Resource Groups."
  value       = { for k, v in azurerm_resource_group.this : k => v.id }
}

output "resource_group_names" {
  description = "Map containing the names of the created Resource Groups."
  value       = { for k, v in azurerm_resource_group.this : k => v.name }
}