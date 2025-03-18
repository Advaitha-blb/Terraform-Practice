terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.23.0"
    }
  }


backend "azurerm" {
  resource_group_name = "NEXTOPS-RG"
  storage_account_name = "nextops-sa"
  container_name = "tfstate"
  key = "PROD/terraform.tfstate"
  access_key = "value" # for authentication even if not az login
}
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  
  features {}
}