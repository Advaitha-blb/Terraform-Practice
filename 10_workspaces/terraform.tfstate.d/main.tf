resource "azurerm_resource_group" "myrg" {
    name                 =  var.rg_name
    location             = var.rg_location
    tags = {
      env = terraform.workspace
    }
}

resource "azurerm_virtual_network" "myvnet" {
    resource_group_name   = azurerm_resource_group.myrg.name
    location              = azurerm_resource_group.myrg.location
    name                  = var.vnet_name
    address_space         = var.vnet_address_space 

    tags = {
      env = terraform.workspace
    }
}
resource "azurerm_subnet" "mysubnet" {
    name = var.subnet_name
    virtual_network_name = azurerm_virtual_network.myvnet.name
    resource_group_name = azurerm_resource_group.myrg.name
    address_prefixes = var.address_prefixes
  
}