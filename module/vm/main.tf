resource "azurerm_linux_virtual_machine" "this" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size

  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = var.admin_password != null ? false : true

  network_interface_ids = [
    var.network_interface_id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_type
    disk_size_gb         = var.os_disk_size_gb
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  dynamic "admin_ssh_key" {
    for_each = var.admin_ssh_public_key != null ? [1] : []
    content {
      username   = var.admin_username
      public_key = var.admin_ssh_public_key
    }
  }

  boot_diagnostics {
    storage_account_uri = var.storage_account_uri
  }

  tags = var.tags
}
