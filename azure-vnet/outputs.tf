output "vnet_ids" {
  description = "Map containing the IDs of the created Virtual Networks."
  value       = { for k, v in azurerm_virtual_network.this : k => v.id }
}

output "subnet_ids" {
  description = "Map containing the IDs of the created Subnets. Key format is 'vnet_name.subnet_name'."
  value       = { for k, v in azurerm_subnet.this : k => v.id }
}