output "vm1" {
  value = azurerm_linux_virtual_machine.vm1.public_ip_address
}

output "vm2" {
  value = azurerm_linux_virtual_machine.vm2.public_ip_address
}