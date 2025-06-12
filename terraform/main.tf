# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "transit-network-rg-rg"
  location = "East US"
}

module "vwan" {
  source              = "./modules/vwan"
  wan_name            = "rg-virtual-wan"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  hub_name            = "rg-virtual-hub"
  hub_sku             = "Standard"
  hub_address_prefix  = "10.100.0.0/16"
  connections = [
    {
      name                      = "spoke1-connection"
      remote_virtual_network_id = module.vnet1.id
    },
    {
      name                      = "spoke2-connection"
      remote_virtual_network_id = module.vnet2.id
    },
    {
      name                      = "spoke3-connection"
      remote_virtual_network_id = module.vnet3.id
    }
  ]
}

module "vnet1" {
  source              = "./modules/vnet"
  name                = "vnet1"
  address_space       = ["10.1.0.0/16"]
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  subnets = [
    {
      name           = "default"
      address_prefix = ["10.1.1.0/24"]
    }
  ]
}

module "vnet2" {
  source              = "./modules/vnet"
  name                = "vnet2"
  address_space       = ["10.2.0.0/16"]
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  subnets = [
    {
      name           = "default"
      address_prefix = ["10.2.1.0/24"]
    }
  ]
}

module "vnet3" {
  source              = "./modules/vnet"
  name                = "vnet3"
  address_space       = ["10.3.0.0/16"]
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  subnets = [
    {
      name           = "default"
      address_prefix = ["10.3.1.0/24"]
    }
  ]
}

resource "azurerm_network_interface" "spoke1_nic" {
  name                = "spoke1-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.vnet1.subnets[0].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "spoke1_vm" {
  name                = "spoke1-vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password      = "Demo12345!"
  network_interface_ids = [
    azurerm_network_interface.spoke1_nic.id,
  ]



  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

resource "azurerm_network_interface" "spoke2_nic" {
  name                = "spoke2-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.vnet2.subnets[0].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "spoke2_vm" {
  name                = "spoke2-vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password      = "Demo12345!"
  network_interface_ids = [
    azurerm_network_interface.spoke2_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

resource "azurerm_network_interface" "spoke3_nic" {
  name                = "spoke2-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.vnet3.subnets[0].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "spoke3_vm" {
  name                = "spoke2-vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password      = "Demo12345!"
  network_interface_ids = [
    azurerm_network_interface.spoke3_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}