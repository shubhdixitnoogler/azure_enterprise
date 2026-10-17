environment         = "prod"
location            = "eastus"
resource_group_name = "rg-enterprise-prod-eastus"
vm_size             = "Standard_D2s_v5"
admin_username      = "azureuser"
admin_password      = "Pr0dP@ssw0rdEnterprise2026!"
enable_bastion      = true

tags = {
  Environment = "Production"
  ManagedBy   = "Terraform"
  Project     = "Azure-Enterprise"
}
