module "tags_mandatory" {
  source          = "../azure-tags"
  tags_mandatory  = var.tags_mandatory
  tags_additional = var.tags_additional
}

resource "azurerm_network_interface" "this" {
  for_each                       = var.nics
  name                           = each.key
  location                       = var.location
  resource_group_name            = each.value.resource_group_name
  dns_servers                    = each.value.dns_servers
  ip_forwarding_enabled          = each.value.ip_forwarding_enabled
  accelerated_networking_enabled = each.value.accelerated_networking_enabled
  internal_dns_name_label        = each.value.internal_dns_name_label

  tags = module.tags_mandatory.tags_mandatory

  dynamic "ip_configuration" {
    for_each = each.value.ip_configurations
    content {
      name                          = ip_configuration.key
      subnet_id                     = ip_configuration.value.subnet_id
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      private_ip_address_version    = ip_configuration.value.private_ip_address_version
      public_ip_address_id          = ip_configuration.value.public_ip_address_id
      private_ip_address            = ip_configuration.value.private_ip_address
      primary                       = ip_configuration.value.primary
    }
  }
}

resource "azurerm_network_interface_security_group_association" "this" {

  for_each = {
    for nic_key, nic_value in var.nics : nic_key => nic_value
    if nic_value.network_security_group_id != null
  }

  network_interface_id      = azurerm_network_interface.this[each.key].id
  network_security_group_id = each.value.network_security_group_id
}