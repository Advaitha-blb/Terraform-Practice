variable "rg_name" {

    type = string
    description = "the name of the resource group"
    default = "AKSRG"
}

variable "rg_location" {
    type = string
    description = "location of the resource"
}

variable "acr_name" {
    type = string

}

variable "acr_sku"{
    type = string
}

variable "aks_name" {
    type = string
  
}
