variable "existing_resource_group_name" {
  description = "The name of an existing resource group."
  type        = string
}

variable "existing_vnet_name" {
  description = "The name of an existing virtual network."
  type        = string
}

variable "existing_subnet_name_fe" {
  description = "The name of an existing subnet for FE."
  type        = string
}

variable "existing_subnet_name_aks" {
  description = "The name of an existing subnet for AKS."
  type        = string
}

variable "resource_tags" {
  description = "Map of tags to apply to taggable resources in this module. By default the taggable resources are tagged with the name defined above and this map is merged in"
  type        = map(string)
  default     = {}
}

variable "subnets" {
  description = "Map of subnets. Keys are subnet names, Allowed values are the same as for subnet_defaults"
  type        = any
  default     = {}

  validation {
    condition = (length(compact([for subnet in var.subnets : (!lookup(subnet, "configure_nsg_rules", true) &&
      (contains(keys(subnet), "allow_internet_outbound") ||
        contains(keys(subnet), "allow_lb_inbound") ||
        contains(keys(subnet), "allow_vnet_inbound") ||
      contains(keys(subnet), "allow_vnet_outbound")) ?
    "invalid" : "")])) == 0)
    error_message = "Subnet rules not allowed when configure_nsg_rules is set to \"false\"."
  }
}

variable "route_tables" {
  description = "Maps of route tables"
  type = map(object({
    disable_bgp_route_propagation = bool
    use_inline_routes             = bool # Setting to true will revert any external route additions.
    routes                        = map(map(string))
    # keys are route names, value map is route properties (address_prefix, next_hop_type, next_hop_in_ip_address)
    # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table#route
  }))
  default = {}
}
