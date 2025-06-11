# Output the hub and spoke details
output "virtual_hub_id" {
  value = azurerm_virtual_hub.example.id
}

output "spoke_vnet_ids" {
  value = {
    spoke1 = azurerm_virtual_network.spoke1.id
    spoke2 = azurerm_virtual_network.spoke2.id
    spoke3 = azurerm_virtual_network.spoke3.id
  }
}