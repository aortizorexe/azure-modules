module "tags_mandatory" {
  source          = "../azure-tags"
  tags_mandatory  = var.tags_mandatory
  tags_additional = var.tags_additional
}

resource "azurerm_virtual_network" "this" {
  for_each            = var.vnets
  name                = each.key
  location            = var.location
  resource_group_name = each.value.resource_group_name
  address_space       = each.value.address_space
  dns_servers         = each.value.dns_servers

  tags = module.tags_mandatory.tags_mandatory
}

locals {
  flat_subnets = flatten([
    for vnet_key, vnet in var.vnets : [
      for subnet_key, subnet in coalesce(vnet.subnets, {}) : {
        vnet_key            = vnet_key
        subnet_key          = subnet_key
        resource_group_name = vnet.resource_group_name
        address_prefixes    = subnet.address_prefixes
        service_endpoints   = subnet.service_endpoints
        delegation          = subnet.delegation
      }
    ]
  ])
}

resource "azurerm_subnet" "this" {
  for_each = { for s in local.flat_subnets : "${s.vnet_key}.${s.subnet_key}" => s }

  name                 = each.value.subnet_key
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = azurerm_virtual_network.this[each.value.vnet_key].name
  address_prefixes     = each.value.address_prefixes
  service_endpoints    = each.value.service_endpoints

  dynamic "delegation" {
    for_each = each.value.delegation != null ? each.value.delegation : {}
    content {
      name = delegation.key
      service_delegation {
        name    = delegation.value.name_service_delegation
        actions = try(delegation.value.actions, [])
      }
    }
  }
}