variable "wan_name"{}
variable "resource_group_name"{}
variable "location"{}
variable "hub_name" {
  default = ""
  type = string  
}
variable "hub_sku" {
  default = ""
  type = string  
}
variable "hub_address_prefix" {
  default = ""
  type = string  
}
variable "connections" {
    type = list(object({
        name                      = string
        remote_virtual_network_id = string
    }))
    default = []
}