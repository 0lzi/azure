# Create a resource group
resource "azurerm_resource_group" "myrg1" {
  name     = "myrg1"
  location = "West Europe"
  tags = {
    env     = "dev"
    project = "az104"
  }
}

resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet1"
  location            = azurerm_resource_group.myrg1.location
  resource_group_name = azurerm_resource_group.myrg1.name
  address_space       = ["10.1.0.0/16"]

}

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.myrg1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.1.0.0/24"]
}

resource "azurerm_public_ip" "prodvm1-pubip" {
  name                = "prodvm1-pubip"
  resource_group_name = azurerm_resource_group.myrg1.name
  location            = azurerm_resource_group.myrg1.location
  allocation_method   = "Static"

  tags = {
    environment = "prod"
  }
}

resource "azurerm_public_ip" "devvm1-pubip" {
  name                = "devvm1-pubip"
  resource_group_name = azurerm_resource_group.myrg1.name
  location            = azurerm_resource_group.myrg1.location
  allocation_method   = "Static"

  tags = {
    environment = "dev"
  }
}
resource "azurerm_network_interface" "prodvm1-nic" {
  name                = "prodvm1-nic"
  location            = azurerm_resource_group.myrg1.location
  resource_group_name = azurerm_resource_group.myrg1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.prodvm1-pubip.id
  }
}

resource "azurerm_network_interface" "devvm1-nic" {
  name                = "devvm1-nic"
  location            = azurerm_resource_group.myrg1.location
  resource_group_name = azurerm_resource_group.myrg1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.devvm1-pubip.id
  }
}

resource "azurerm_linux_virtual_machine" "prodvm1" {
  name                            = "prodvm1"
  resource_group_name             = azurerm_resource_group.myrg1.name
  location                        = azurerm_resource_group.myrg1.location
  size                            = "Standard_B1s"
  admin_username                  = "azureuser"
  admin_password                  = var.admin_password
  disable_password_authentication = false
  tags = {
    env = "prod"
  }
  network_interface_ids = [
    azurerm_network_interface.prodvm1-nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
}

resource "azurerm_linux_virtual_machine" "devvm1" {
  name                            = "devvm1"
  resource_group_name             = azurerm_resource_group.myrg1.name
  location                        = azurerm_resource_group.myrg1.location
  size                            = "Standard_B1s"
  admin_username                  = "azureuser"
  admin_password                  = var.admin_password
  disable_password_authentication = false
  tags = {
    env = "dev"
  }
  network_interface_ids = [
    azurerm_network_interface.devvm1-nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
}