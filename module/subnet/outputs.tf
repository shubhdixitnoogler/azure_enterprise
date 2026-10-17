output "vm_subnet_id" {
  description = "The ID of the VM subnet"
  value       = azurerm_subnet.vm_subnet.id
}

output "vm_subnet_name" {
  description = "The name of the VM subnet"
  value       = azurerm_subnet.vm_subnet.name
}

output "bastion_subnet_id" {
  description = "The ID of the Bastion subnet, if created"
  value       = var.enable_bastion_subnet ? azurerm_subnet.bastion_subnet[0].id : null
}
