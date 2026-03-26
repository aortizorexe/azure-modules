module "tags_mandatory" {
  source          = "../azure-tags"
  tags_mandatory  = var.tags_mandatory
  tags_additional = var.tags_additional
}

resource "azurerm_route_table" "this" {
  for_each                      = var.route_tables
  name                          = each.key
  location                      = var.location
  resource_group_name           = each.value.resource_group_name
  bgp_route_propagation_enabled = each.value.bgp_route_propagation_enabled

  dynamic "route" {
    for_each = each.value.routes
    content {
      name                   = route.key
      address_prefix         = route.value.address_prefix
      next_hop_type          = route.value.next_hop_type
      next_hop_in_ip_address = route.value.next_hop_in_ip_address
    }
  }

  tags = module.tags_mandatory.tags_mandatory
}

locals {
  rt_subnet_associations = flatten([
    for rt_key, rt in var.route_tables : [
      for subnet_key, subnet_id in rt.subnet_ids : {
        route_table_key = rt_key
        subnet_key      = subnet_key
        subnet_id       = subnet_id
      }
    ]
  ])
}

resource "azurerm_subnet_route_table_association" "this" {
  for_each = { for assoc in local.rt_subnet_associations : "${assoc.route_table_key}.${assoc.subnet_key}" => assoc }

  subnet_id      = each.value.subnet_id
  route_table_id = azurerm_route_table.this[each.value.route_table_key].id
}