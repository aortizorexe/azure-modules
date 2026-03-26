output "route_table_ids" {
  description = "Map containing the IDs of the created Route Tables."
  value       = { for k, v in azurerm_route_table.this : k => v.id }
}