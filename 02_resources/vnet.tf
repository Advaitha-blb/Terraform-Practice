

resource "azurerm_resource_group" "myrg" {
  name     = "NEXTOPS-RG"
  location = "North Europe"
}



resource "azurerm_virtual_network" "myvnet" {
  name                = "NEXTOPS-VNET"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  tags = {
    environment = "Production"
  }
}

resource "azurerm_subnet" "subnet1" {
    name                 = "Subnet1"
    resource_group_name  = azurerm_resource_group.myrg.name
    virtual_network_name = azurerm_virtual_network.myvnet.name
    address_prefixes     = ["10.0.1.0/24"]
  
}

resource "azurerm_subnet" "subnet2" {
    name                 = "Subnet2"
    resource_group_name  = azurerm_resource_group.myrg.name
    virtual_network_name = azurerm_virtual_network.myvnet.name
    address_prefixes     = ["10.0.2.0/24"]
  
}

resource "azurerm_public_ip" "mypublicip" {
  name                = "NEXTOPS-PIP"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "mynic" {
  name                = "NEXTOPS-NIC"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.mypublicip.id
  }
}

resource "azurerm_network_security_group" "mynsg" {
  name                = "NEXTOPS-NSG"
  location            = azurerm_resource_group.myrg.location        
  resource_group_name = azurerm_resource_group.myrg.name

  security_rule {
    name                       = "Allow-RDP"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

resource "azurerm_subnet_network_security_group_association" "mynsgassociation" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.mynsg.id
}

