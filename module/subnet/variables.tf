variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "virtual_network_name" {
  type        = string
  description = "The name of the virtual network"
}

variable "vm_subnet_name" {
  type        = string
  description = "The name of the subnet for virtual machines"
  default     = "snet-vm"
}

variable "vm_subnet_prefixes" {
  type        = list(string)
  description = "Address prefixes for the VM subnet"
  default     = ["10.0.1.0/24"]
}

variable "enable_bastion_subnet" {
  type        = bool
  description = "Whether to create the AzureBastionSubnet"
  default     = false
}

variable "bastion_subnet_prefixes" {
  type        = list(string)
  description = "Address prefixes for the AzureBastionSubnet (must be at least /26)"
  default     = ["10.0.2.0/26"]
}
