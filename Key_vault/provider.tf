
terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/terraform"
        version = "4.35.0"
    }
  }
}

  provider "azurerm" {
    features {}
    subscription_id = var.subscription_id
    client_id = var.client_id
    client_secret = var.client_secret
    tenant_id = var.tenant_id
        
    
    
  }
