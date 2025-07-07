resource "azurerm_resource_group" "rg" {
    name = var.rg_name
    location = var.rg_location
  
}

resource "azurerm_key_vault" "mykv" {
    name = "Demo-Key-Vault"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    SKU = "Standard"
    enable_for_disk_encryption = true
    soft_delete_retention_days = 7
    purge_protection_enabled = false

    access_poicy{
        Key_permissions = [
            Get;
        ]
        storage_permissions = [
            Get;
        ]
        secret_permissions = [
            Get;
        ]
    }
  
}