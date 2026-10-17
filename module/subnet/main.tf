resource "azurerm_subnet" "vm_subnet" {
  name                 = var.vm_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.vm_subnet_prefixes
}

resource "azurerm_subnet" "bastion_subnet" {
  count                = var.enable_bastion_subnet ? 1 : 0
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.bastion_subnet_prefixes
}
