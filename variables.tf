variable "existing_resource_group_name" {
  description = "The name of the existing resource group containing the virtual network."
  type        = string
}

variable "existing_vnet_name" {
  description = "The name of the existing virtual network."
  type        = string
}

variable "existing_subnet_name_fe" {
  description = "The name of the existing subnet for FE."
  type        = string
}

variable "existing_subnet_name_aks" {
  description = "The name of the existing subnet for AKS."
  type        = string
}

variable "resource_tags" {
  description = "Map of tags to apply to taggable resources in this module. By default the taggable resources are tagged with the name defined above and this map is merged in"
  type        = map(string)
  default     = {}
}

variable "aks_route_table" {
  description = "Map of AKS route table"
  type = object({
    route_table_name              = string
    disable_bgp_route_propagation = bool
    use_inline_routes             = bool # Setting to true will revert any external route additions.
    routes                        = map(map(string))
    # keys are route names, value map is route properties (address_prefix, next_hop_type, next_hop_in_ip_address)
    # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table#route
  })
}