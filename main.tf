resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_virtual_machine" "example2" {
  location              = "us-east-1"
  name                  = "hemanth-vm"
  network_interface_ids = []
  resource_group_name   = "Hemanth_RG"
  vm_size               = "b1s.small"
}

# NSG 1 - Allow all inbound traffic on all ports
resource "azurerm_network_security_group" "nsg1" {
  name                = "nsg-allow-all"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name                       = "allow-all"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Production"
  }
}

# NSG 2 - Allow HTTP (port 80)
resource "azurerm_network_security_group" "nsg2" {
  name                = "nsg-allow-http"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name                       = "allow-http"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Development"
  }
}

# NSG 3 - Allow SSH (port 22)
resource "azurerm_network_security_group" "nsg3" {
  name                = "nsg-allow-ssh"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name                       = "allow-ssh"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Staging"
  }
}

# NSG 4 - Allow all outbound traffic
resource "azurerm_network_security_group" "nsg4" {
  name                = "nsg-allow-outbound"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name                       = "allow-all-outbound"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Test"
  }
}

resource "azurerm_storage_account" "storage1" {
  name                     = "storageaccount124"
  resource_group_name      = "example-rg"
  location                 = "East US"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_account" "storage2" {
  name                     = "storageaccount21234"
  resource_group_name      = "example-rg"
  location                 = "East US"
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

