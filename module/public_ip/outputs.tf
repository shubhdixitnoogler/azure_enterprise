output "id" {
  description = "The ID of the public IP"
  value       = azurerm_public_ip.this.id
}

output "ip_address" {
  description = "The assigned public IP address"
  value       = azurerm_public_ip.this.ip_address
}

output "name" {
  description = "The name of the public IP resource"
  value       = azurerm_public_ip.this.name
}
