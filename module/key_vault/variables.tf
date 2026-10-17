variable "key_vault_name" {
  type        = string
  description = "The name of the Key Vault (globally unique, 3-24 alphanumeric and dashes)"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "The Azure region for the Key Vault"
}

variable "sku_name" {
  type        = string
  description = "The SKU of the Key Vault: standard or premium"
  default     = "standard"
}

variable "admin_password" {
  type        = string
  description = "Admin password to store as a secret (optional)"
  default     = null
  sensitive   = true
}

variable "tags" {
  type        = map(string)
  description = "Tags to be assigned to the Key Vault"
  default     = {}
}
