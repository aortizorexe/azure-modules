output "storage_account_ids" {
  description = "Map containing the IDs of the created Storage Accounts."
  value       = { for k, v in azurerm_storage_account.this : k => v.id }
}

output "storage_account_primary_endpoints" {
  description = "Map containing the primary blob endpoints of the created Storage Accounts."
  value       = { for k, v in azurerm_storage_account.this : k => v.primary_blob_endpoint }
}