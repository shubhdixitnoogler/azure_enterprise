output "id" {
  description = "The ID of the network interface"
  value       = azurerm_network_interface.this.id
}

output "private_ip_address" {
  description = "The private IP address of the network interface"
  value       = azurerm_network_interface.this.private_ip_address
}

output "name" {
  description = "The name of the network interface"
  value       = azurerm_network_interface.this.name
}
