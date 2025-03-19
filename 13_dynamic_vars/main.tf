resource "azurerm_resource_group" "rg" {
    name = var.rgname
    location = var.rglocation
  
}

#please inputa value for while running terraform apply. If provided input == no (case-sensitive) this code will deploy
#dev related resources 
resource "azurerm_virtual_network" "vnet" {
    name = var.env_prod == "no"  ?  "dev-vnet"  :  "prod-vnet"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location

    address_space = var.env_prod == "no" ? [ "10.90.0.0/16" ] : ["10.80.0.0/16"] 
    
  
}
resource "azurerm_subnet" "subnet01" {
    name = var.env_prod == "no"  ?  "dev.subnet1"    :   "prod-subnet1"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = var.env_prod == "no"  ?  ["10.90.0.0/24"] :  ["10.80.0.0./24"]
}