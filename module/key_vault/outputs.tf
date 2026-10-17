output "id" {
  description = "The ID of the Key Vault"
  value       = azurerm_key_vault.this.id
}

output "vault_uri" {
  description = "The URI of the Key Vault"
  value       = azurerm_key_vault.this.vault_uri
}

output "secret_id" {
  description = "The ID of the stored admin password secret"
  value       = var.admin_password != null ? azurerm_key_vault_secret.vm_admin_password[0].id : null
}
