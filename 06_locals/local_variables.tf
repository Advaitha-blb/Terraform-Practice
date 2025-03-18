variable "rg_name" {

    type = string
    description = "the name of the resource group"
    default = "AKSRG"
}

variable "rg_location" {
    type = string
    description = "location of the resource"
}
variable "vnet_name" {
    type = string
    description = "name of the vnet"
}
variable "vnet_address_space" {
    type = list(string)
  
}
variable "subnet_name"{
    type = string
}
variable "address_prefix" {
    type = list(string)
  
}
