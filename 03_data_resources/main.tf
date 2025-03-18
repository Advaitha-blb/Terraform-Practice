data "azurerm_resource_group" "existingrg" {
   name = "NEXTOPS-RG"
}                                                              

data "azurerm_virtual_network" "existingvnet" {
   name                = "NEXTOPS-VNET"
   resource_group_name = data.azurerm_resource_group.existingrg.name
}

data "azurerm_subnet" "existingsubnet" {
   name                 = "Subnet1"
   virtual_network_name = data.azurerm_virtual_network.existingvnet.name
   resource_group_name  = data.azurerm_resource_group.existingrg.name
} 

resource "azurerm_subnet" "subnet3" {
    name = "Subnet3"
    resource_group_name = data.azurerm_resource_group.existingrg.name
    virtual_network_name = data.azurerm_virtual_network.existingvnet.name
    address_prefixes = ["10.0.4.0/24"]
}

resource "azurerm_network_interface" "nic1" {
    name =  "NEXTOPS-NIC1"
    location = data.azurerm_resource_group.existingrg.location
    resource_group_name = data.azurerm_resource_group.existingrg.name   

    ip_configuration {
        name = "internal"
        subnet_id = data.azurerm_subnet.existingsubnet.id
        private_ip_address_allocation = "Dynamic"
    }
  
}