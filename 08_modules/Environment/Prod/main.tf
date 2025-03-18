module "dev" {
    source = "../../webapp_module"
    rg_name = "ProdRG"
    rg_location = "East US"
    asp_name = "prodaspt21"
    app_name = "nextopsprodapp"
    os_type = "linux"
    sku_name = "B1"
    
  
}