variable "public_ip_name" {
  type        = string
  description = "The name of the public IP resource"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "The Azure region for the public IP"
}

variable "allocation_method" {
  type        = string
  description = "IP allocation method: Static or Dynamic"
  default     = "Static"
}

variable "sku" {
  type        = string
  description = "The SKU of the public IP: Standard or Basic"
  default     = "Standard"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be assigned to the public IP"
  default     = {}
}
