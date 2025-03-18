variable "rg_name" {
    type = string

}

variable "rg_location" {
    type = string
    
}
variable "vnet_name" {
    type = string
    
}
variable "vnet_address_space" {

    type = list(string)
    
}
variable "subnet_name" {
    type = string
    
}

variable "address_prefixes" {

    type = list(string)
    
}