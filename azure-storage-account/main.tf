module "tags_mandatory" {
  source          = "../azure-tags"
  tags_mandatory  = var.tags_mandatory
  tags_additional = var.tags_additional
}

resource "azurerm_storage_account" "this" {
  for_each = var.storage_accounts

  name                     = each.key
  resource_group_name      = each.value.resource_group_name
  location                 = var.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type

  min_tls_version               = "TLS1_2"
  public_network_access_enabled = each.value.public_network_access_enabled
  shared_access_key_enabled     = each.value.shared_access_key_enabled

  tags = module.tags_mandatory.tags_mandatory

  dynamic "network_rules" {
    for_each = each.value.network_rules != null ? [each.value.network_rules] : []
    content {
      default_action             = network_rules.value.default_action
      bypass                     = network_rules.value.bypass
      ip_rules                   = network_rules.value.ip_rules
      virtual_network_subnet_ids = network_rules.value.virtual_network_subnet_ids
    }
  }

  dynamic "blob_properties" {
    for_each = each.value.blob_properties != null ? [each.value.blob_properties] : []
    content {
      versioning_enabled = blob_properties.value.versioning_enabled

      delete_retention_policy {
        days = blob_properties.value.delete_retention_days
      }
    }
  }
}