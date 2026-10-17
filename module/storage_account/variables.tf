variable "storage_account_name" {
  type        = string
  description = "The name of the storage account (must be unique globally, 3-24 lowercase alphanumeric)"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "The Azure region for the storage account"
}

variable "account_replication_type" {
  type        = string
  description = "Replication type: LRS, GRS, RAGRS, ZRS"
  default     = "LRS"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be assigned to the storage account"
  default     = {}
}
