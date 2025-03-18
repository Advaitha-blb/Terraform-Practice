resourcedetails = {
  "eastus" = {
      rg_name           = "EastUSRG"
      rg_location       = "EastUS"
      vnet_name         = "Eastvnet"
      address_space     = ["10.20.0.0/16"]
      subnet_name       = "eastsubnet"
      address_prefixes  = ["10.20.0.0/24"]
      vm_name           = "eastVM"
      size              = "Standard_B1s"
    
  }
  "westus" =     {
    rg_name             = "WestUSRG"
      rg_location       = "WestUS"
      vnet_name         = "Westvnet"
      address_space     = ["10.30.0.0/16"]
      subnet_name       = "westsubnet"
      address_prefixes  = ["10.30.0.0/24"]
      vm_name           = "westVM"
      size              = "Standard_B2s"
  }
}