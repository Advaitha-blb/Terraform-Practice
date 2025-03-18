resource "azurerm_resource_group" "aksrg"{
    name                = "var.rg_name"
    location            = "var.rg_location"
}

resource "azurerm_container_registry" "myacr" {
    name                = var.acr_name
    resource_group_name = azurerm_resource_group.aksrg.name
    location            =  azurerm_resource_group.aksrg.location
    sku                 = var.acr_sku
}

resource "azurerm_kubernetes_cluster" "myaks" {
    name                = var.aks_name
    resource_group_name = azurerm_resource_group.aksrg.name
    location            = azurerm_resource_group.aksrg.location

    default_node_pool {

        name                 = "default"
        vm_size              = "Standard_DS2_v2"
        node_count           = "1"
        enable_auto_scaling  = false
        max_count            = ""
        min_count            = ""
    }
    network_profile {
      network_plugin         = "azure"
      network_mode           = ""
      
      pod_cidr               = "10.10.0.0/16"
      network_policy         = "calico"
      load_balancer_sku      = "Standard"
      service_cidr           = "10.11.0.0/16"
      dns_service_ip         = "10.11.0.10"
    }

    identity {
      type                   = "SystemAssigned"
    }

    key_vault_secrets_provider {
      secret_rotation_enabled  = "false"
      secret_rotation_interval = "1"
    }

    
    }  

    resource "azurerm_role_assignment" "aks2acr" {
        principal_id                     = azurerm_kubernetes_cluster.myaks.kubelet[0].object_id
        scope                            = azurerm_container_registry.myacr.id
        role_definition_name             = "AcrPullRole"
        skip_service_principal_aad_check = "true"

    }
