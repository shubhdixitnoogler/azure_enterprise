variable "network_interface_name" {
  type        = string
  description = "The name of the network interface"
}

variable "location" {
  type        = string
  description = "The Azure region for the network interface"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet to attach the NIC to"
}

variable "public_ip_id" {
  type        = string
  description = "The ID of the public IP to attach (optional)"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags to be assigned to the network interface"
  default     = {}
}
