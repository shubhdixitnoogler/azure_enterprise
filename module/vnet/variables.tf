variable "virtual_network_name" {
  type        = string
  description = "The name of the virtual network"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "The Azure region for the virtual network"
}

variable "address_space" {
  type        = list(string)
  description = "The address space used by the virtual network"
  default     = ["10.0.0.0/16"]
}

variable "tags" {
  type        = map(string)
  description = "Tags to be assigned to the virtual network"
  default     = {}
}
