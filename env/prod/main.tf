resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

# 1. Resource Group
module "resource_group" {
  source              = "../../module/resource_group"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

# 2. Virtual Network
module "vnet" {
  source               = "../../module/vnet"
  virtual_network_name = "vnet-${var.environment}-${var.location}"
  resource_group_name  = module.resource_group.name
  location             = module.resource_group.location
  address_space        = var.vnet_address_space
  tags                 = var.tags
}

# 3. Subnets (VM subnet + Bastion subnet)
module "subnet" {
  source                = "../../module/subnet"
  resource_group_name   = module.resource_group.name
  virtual_network_name  = module.vnet.name
  vm_subnet_name        = "snet-vm-${var.environment}"
  vm_subnet_prefixes    = var.vm_subnet_prefixes
  enable_bastion_subnet = var.enable_bastion
}

# 4. Network Security Group
module "nsg" {
  source                      = "../../module/nsg"
  network_security_group_name = "nsg-vm-${var.environment}"
  resource_group_name         = module.resource_group.name
  location                    = module.resource_group.location
  subnet_id                   = module.subnet.vm_subnet_id
  allow_ssh                   = false # Disabled in prod; use Bastion instead
  allow_http                  = true
  allow_https                 = true
  tags                        = var.tags
}

# 5. Network Interface Card (Private IP only in Prod)
module "nic" {
  source                 = "../../module/nic"
  network_interface_name = "nic-vm-${var.environment}"
  resource_group_name    = module.resource_group.name
  location               = module.resource_group.location
  subnet_id              = module.subnet.vm_subnet_id
  tags                   = var.tags
}

# 6. Storage Account (for Boot Diagnostics)
module "storage_account" {
  source                   = "../../module/storage_account"
  storage_account_name     = "st${var.environment}${random_string.suffix.result}"
  resource_group_name      = module.resource_group.name
  location                 = module.resource_group.location
  account_replication_type = "GRS"
  tags                     = var.tags
}

# 7. Azure Key Vault (stores credentials and secrets)
module "key_vault" {
  source              = "../../module/key_vault"
  key_vault_name      = "kv-${var.environment}-${random_string.suffix.result}"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  sku_name            = "standard"
  admin_password      = var.admin_password
  tags                = var.tags
}

# 8. Virtual Machine
module "vm" {
  source               = "../../module/vm"
  vm_name              = "vm-${var.environment}"
  resource_group_name  = module.resource_group.name
  location             = module.resource_group.location
  vm_size              = var.vm_size
  admin_username       = var.admin_username
  admin_password       = var.admin_password
  network_interface_id = module.nic.id
  os_disk_type         = "Premium_LRS"
  storage_account_uri  = module.storage_account.primary_blob_endpoint
  tags                 = var.tags
}

# 9. Azure Bastion Host for Secure Jumpbox Access
module "bastion_public_ip" {
  count               = var.enable_bastion ? 1 : 0
  source              = "../../module/public_ip"
  public_ip_name      = "pip-bastion-${var.environment}"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

module "bastion" {
  count               = var.enable_bastion ? 1 : 0
  source              = "../../module/bastion"
  bastion_name        = "bas-${var.environment}"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  subnet_id           = module.subnet.bastion_subnet_id
  public_ip_id        = module.bastion_public_ip[0].id
  tags                = var.tags
}
