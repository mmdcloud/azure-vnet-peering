# Create Virtual WAN
resource "azurerm_virtual_wan" "wan" {
  name                = var.wan_name
  resource_group_name = var.resource_group_name
  location            = var.location
}

# Create Virtual Hub (acts as the transit gateway)
resource "azurerm_virtual_hub" "hub" {
  name                = var.hub_name
  resource_group_name = var.resource_group_name
  location            = var.location
  virtual_wan_id      = azurerm_virtual_wan.wan.id
  address_prefix      = var.hub_address_prefix
  sku                 = var.hub_sku
}

# Connect spoke VNets to the hub (transit)
resource "azurerm_virtual_hub_connection" "connection" {
  count = length(var.connections)
  name                      = var.connections[count.index].name
  virtual_hub_id            = azurerm_virtual_hub.hub.id
  remote_virtual_network_id =  var.connections[count.index].remote_virtual_network_id
}