output "nic_ids" {
  description = "Map containing the IDs of the created Network Interfaces."
  value       = { for k, v in azurerm_network_interface.this : k => v.id }
}

output "nic_private_ips" {
  description = "Map containing the private IP addresses of the created Network Interfaces."
  value       = { for k, v in azurerm_network_interface.this : k => v.private_ip_address }
}