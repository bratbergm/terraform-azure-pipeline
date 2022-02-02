resource "azurerm_virtual_network" "vnet" {
    resource_group_name = var.resource_group_name
    location            = var.location
    name                = "${var.environment}-${var.vnet_name}"
    address_space       = var.address_space
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name # / azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_prefixes
}

resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}