module "tags_mandatory" {
  source          = "../azure-tags"
  tags_mandatory  = var.tags_mandatory
  tags_additional = var.tags_additional
}

resource "azurerm_windows_virtual_machine" "this" {
  for_each            = var.vms
  name                = each.key
  location            = var.location
  resource_group_name = each.value.resource_group_name
  size                = each.value.size
  admin_username      = each.value.admin_username
  admin_password      = each.value.admin_password

  network_interface_ids = each.value.network_interface_ids

  os_disk {
    name                 = "${each.key}-osdisk"
    caching              = each.value.os_disk.caching
    storage_account_type = each.value.os_disk.storage_account_type
    disk_size_gb         = each.value.os_disk.disk_size_gb
  }

  source_image_reference {
    publisher = each.value.source_image_reference.publisher
    offer     = each.value.source_image_reference.offer
    sku       = each.value.source_image_reference.sku
    version   = each.value.source_image_reference.version
  }

  tags = module.tags_mandatory.tags_mandatory
}