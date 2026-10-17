variable "bastion_name" {
  type        = string
  description = "The name of the Azure Bastion host"
}

variable "location" {
  type        = string
  description = "The Azure region for the Bastion host"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "sku" {
  type        = string
  description = "The SKU of the Bastion host: Basic, Standard, or Developer"
  default     = "Standard"
}

variable "subnet_id" {
  type        = string
  description = "The ID of the AzureBastionSubnet"
}

variable "public_ip_id" {
  type        = string
  description = "The ID of the public IP address for the Bastion host"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be assigned to the Bastion host"
  default     = {}
}
