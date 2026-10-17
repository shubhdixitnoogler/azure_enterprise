variable "network_security_group_name" {
  type        = string
  description = "The name of the network security group"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "The Azure region for the network security group"
}

variable "allow_ssh" {
  type        = bool
  description = "Enable inbound SSH rule (port 22)"
  default     = true
}

variable "ssh_source_address_prefix" {
  type        = string
  description = "Source IP or CIDR allowed for SSH access"
  default     = "*"
}

variable "allow_http" {
  type        = bool
  description = "Enable inbound HTTP rule (port 80)"
  default     = true
}

variable "allow_https" {
  type        = bool
  description = "Enable inbound HTTPS rule (port 443)"
  default     = true
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID to associate with this NSG (optional)"
  default     = null
}

variable "associate_with_subnet" {
  type        = bool
  description = "Whether to associate this NSG with the subnet"
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Tags to be assigned to the NSG"
  default     = {}
}
