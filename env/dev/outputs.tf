output "resource_group_name" {
  description = "Name of the resource group"
  value       = module.resource_group.name
}

output "vm_name" {
  description = "Name of the virtual machine"
  value       = module.vm.name
}

output "vm_private_ip" {
  description = "Private IP address of the virtual machine"
  value       = module.nic.private_ip_address
}

output "vm_public_ip" {
  description = "Public IP address of the virtual machine"
  value       = module.public_ip.ip_address
}

output "ssh_login_command" {
  description = "Command to SSH into the virtual machine"
  value       = "ssh ${var.admin_username}@${module.public_ip.ip_address}"
}

output "key_vault_uri" {
  description = "URI of the Azure Key Vault"
  value       = module.key_vault.vault_uri
}

output "storage_account_name" {
  description = "Name of the storage account for boot diagnostics"
  value       = module.storage_account.name
}
