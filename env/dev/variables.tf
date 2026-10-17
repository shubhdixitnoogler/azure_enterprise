variable "environment" {
  type        = string
  description = "Environment name (e.g., dev, prod)"
  default     = "dev"
}

variable "location" {
  type        = string
  description = "Azure region for deployment"
  default     = "eastus"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
  default     = "rg-enterprise-dev-eastus"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Address space for the virtual network"
  default     = ["10.0.0.0/16"]
}

variable "vm_subnet_prefixes" {
  type        = list(string)
  description = "Address prefix for the VM subnet"
  default     = ["10.0.1.0/24"]
}

variable "vm_size" {
  type        = string
  description = "Size of the VM"
  default     = "Standard_D2als_v7"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the VM"
  default     = "azureuser"
}

variable "admin_password" {
  type        = string
  description = "Admin password for the VM (stored securely in Key Vault)"
  default     = "P@ssw0rdEnterprise2026!"
  sensitive   = true
}

variable "enable_bastion" {
  type        = bool
  description = "Whether to deploy Azure Bastion"
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default = {
    Environment = "Development"
    ManagedBy   = "Terraform"
    Project     = "Azure-Enterprise"
  }
}
