module "dev" {
    source = "../../webapp_module"
    rg_name = "QaRG"
    rg_location = "East US"
    asp_name = "qaaspt21"
    app_name = "nextopsqaapp"
    os_type = "linux"
    sku_name = "B1"
    
  
}