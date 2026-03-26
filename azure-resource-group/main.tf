module "tags_mandatory" {
  source          = "../azure-tags"
  tags_mandatory  = var.tags_mandatory
  tags_additional = var.tags_additional
}

resource "azurerm_resource_group" "this" {
  for_each = var.resource_groups
  name     = each.key
  location = coalesce(each.value.location, var.location)
  tags     = module.tags_mandatory.tags_mandatory
}