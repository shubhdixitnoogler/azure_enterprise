variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "The Azure region where the resource group will be created"
  default     = "eastus"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be assigned to the resource group"
  default     = {}
}
