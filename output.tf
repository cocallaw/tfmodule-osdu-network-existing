output "exist_vnet_name" {
  description = "Virtual network name."
  value       = data.azurerm_virtual_network.exist_vnet.name
}

output "exist_vnet_id" {
  description = "Virtual network id."
  value       = data.azurerm_virtual_network.exist_vnet.id
}

output "fe_sn_id" {
  description = "Subnet data object."
  value       = data.azurerm_subnet.exist_sn_fe.id
}

output "aks_sn_id" {
  description = "Subnet data object."
  value       = data.azurerm_subnet.exist_sn_aks.id
}
  
output "route_tables" {
  description = "Maps of custom route tables."
  value = { for k, v in var.route_tables :
    k => {
      name    = azurerm_route_table.route_table[k].name
      id      = azurerm_route_table.route_table[k].id
      subnets = azurerm_route_table.route_table[k].subnets
    }
  }
}