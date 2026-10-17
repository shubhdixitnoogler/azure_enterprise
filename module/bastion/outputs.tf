output "id" {
  description = "The ID of the Azure Bastion host"
  value       = azurerm_bastion_host.this.id
}

output "dns_name" {
  description = "The FQDN of the Azure Bastion host"
  value       = azurerm_bastion_host.this.dns_name
}
