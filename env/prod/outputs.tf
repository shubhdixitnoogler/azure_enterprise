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

output "bastion_dns_name" {
  description = "DNS name of Azure Bastion host for secure access"
  value       = var.enable_bastion ? module.bastion[0].dns_name : null
}

output "key_vault_uri" {
  description = "URI of Azure Key Vault"
  value       = module.key_vault.vault_uri
}

output "storage_account_name" {
  description = "Name of the storage account for boot diagnostics"
  value       = module.storage_account.name
}
