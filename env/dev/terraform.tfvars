environment         = "dev"
location            = "eastus"
resource_group_name = "rg-enterprise-dev-eastus"
vm_size             = "Standard_B1s"
admin_username      = "azureuser"
admin_password      = "P@ssw0rdEnterprise2026!"
enable_bastion      = false

tags = {
  Environment = "Development"
  ManagedBy   = "Terraform"
  Project     = "Azure-Enterprise"
}
