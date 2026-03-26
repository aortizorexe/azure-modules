output "vm_ids" {
  description = "Map containing the IDs of the created Virtual Machines."
  value       = { for k, v in azurerm_windows_virtual_machine.this : k => v.id }
}