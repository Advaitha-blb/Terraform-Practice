resource "azurerm_resource_group" "myrg" {
    name                 =  var.rg_name
    location             = var.rg_location
}

resource "azurerm_virtual_network" "myvnet" {
    resource_group_name   = azurerm_resource_group.myrg.name
    location              = azurerm_resource_group.myrg.location
    name                  = var.vnet_name
    address_space         = var.vnet_address_space 
}
resource "azurerm_subnet" "mysubnet" {
    count                = length(var.subnet_name) # 4
    name                 = var.subnet_name[count.index] # var.subnet_name[0] = subnet1, var.subnet_name[1] = subnet2,...
    resource_group_name  = azurerm_resource_group.my.name
    virtual_network_name = var.vnet_name
    address_prefixes     = ["10.0.${count.index}.0/24"]

}
resource "azurerm_network_interface" "mynic" {
    count               = 5
    name                = "nextops-nic-${count.index}"
    location            = azurerm_resource_group.myrg.location
    resource_group_name = azurerm_resource_group.myrg.name
    ip_configuration {
      name = "ipconfig1"
      subnet_id = azurerm_subnet.mysubnet.id[count.index].id
      private_ip_address_allocation = "dynamic"
    }

  
}

resource "azurerm_linux_virtual_machine" "myvm" {
    count                    = 5
    name                     = "nextopsvm-${count.index}"
    location                 = azurerm_resource_group.myrg.location
    resource_group_name      = azurerm_resource_group.myrg.name
    size                     = "Standard_B1s"
    admin_username           = "azureadmin"
    network_interface_ids    = [azurerm_network_interface.mynic[count.index].id]

    admin_ssh_key {
        username            = "azureadmin"
        # ssh-keygen -t rsa -f C:/Terraform/SSHkeys/17032025
        public_key          = file("C:/Terraform/SSHkeys/17032025/id_rsa.pub")
    }

    os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  
}