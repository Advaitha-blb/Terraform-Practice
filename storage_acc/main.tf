resource "azurerm_resource_group" "RG" {
    name = var.rg_name
    location = var.rg_location
  
}

resource "azurerm_storage_account" "Storage" {
    name = "my_Storage"
    resource_group_name = azurerm_resource_group.RG.name
    location = azurerm_resource_group.RG.location
    account_tier = "Standard"
    account_replication_type = "LRS"

    tags = {
      environment = "TEST"
    }
  
}