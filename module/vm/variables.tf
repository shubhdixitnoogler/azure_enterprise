variable "vm_name" {
  type        = string
  description = "The name of the virtual machine"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "The Azure region for the virtual machine"
}

variable "vm_size" {
  type        = string
  description = "The SKU size of the virtual machine"
  default     = "Standard_B1s"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the VM"
  default     = "azureuser"
}

variable "admin_password" {
  type        = string
  description = "Admin password for the VM (optional if SSH key is provided)"
  default     = null
  sensitive   = true
}

variable "admin_ssh_public_key" {
  type        = string
  description = "SSH public key content for key-based authentication"
  default     = null
}

variable "network_interface_id" {
  type        = string
  description = "The ID of the network interface attached to the VM"
}

variable "os_disk_type" {
  type        = string
  description = "Storage account type for the OS disk (Standard_LRS, Premium_LRS, StandardSSD_LRS)"
  default     = "Standard_LRS"
}

variable "os_disk_size_gb" {
  type        = number
  description = "The size of the OS disk in gigabytes"
  default     = 30
}

variable "image_publisher" {
  type        = string
  description = "Publisher of the OS image"
  default     = "Canonical"
}

variable "image_offer" {
  type        = string
  description = "Offer of the OS image"
  default     = "0001-com-ubuntu-server-jammy"
}

variable "image_sku" {
  type        = string
  description = "SKU of the OS image"
  default     = "22_04-lts-gen2"
}

variable "image_version" {
  type        = string
  description = "Version of the OS image"
  default     = "latest"
}

variable "storage_account_uri" {
  type        = string
  description = "Storage account blob endpoint for boot diagnostics (pass empty/null to use managed)"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags to be assigned to the virtual machine"
  default     = {}
}
