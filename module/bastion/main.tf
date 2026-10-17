resource "azurerm_bastion_host" "this" {
  name                = var.bastion_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku

  ip_configuration {
    name                 = "bastion-ip-config"
    subnet_id            = var.subnet_id
    public_ip_address_id = var.public_ip_id
  }

  copy_paste_enabled     = true
  file_copy_enabled      = var.sku == "Standard" ? true : false
  ip_connect_enabled     = var.sku == "Standard" ? true : false
  shareable_link_enabled = var.sku == "Standard" ? true : false
  tunneling_enabled      = var.sku == "Standard" ? true : false

  tags = var.tags
}
