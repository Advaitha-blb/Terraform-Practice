module "dev" {
    source = "../../webapp_module"
    rg_name = "DevRG"
    rg_location = "East US"
    asp_name = "devaspt21"
    app_name = "nextopsdevapp"
    os_type = "linux"
    sku_name = "B1"
    
  
}