data "azurerm_resource_group" "exist_rg" {
  name = var.existing_resource_group_name
}

data "azurerm_virtual_network" "exist_vnet" {
  name                = var.existing_vnet_name
  resource_group_name = data.azurerm_resource_group.exist_rg.name
}

data "azurerm_subnet" "exist_sn_fe" {
  name                = var.existing_subnet_name_fe
  virtual_network_name = data.azurerm_virtual_network.exist_vnet.name
  resource_group_name = data.azurerm_resource_group.exist_rg.name
}

data "azurerm_subnet" "exist_sn_aks" {
  name                = var.existing_subnet_name_aks
  virtual_network_name = data.azurerm_virtual_network.exist_vnet.name
  resource_group_name = data.azurerm_resource_group.exist_rg.name
}

resource "azurerm_route_table" "route_table_aks" {
  name                          = var.aks_route_table.route_table_name
  location                      = data.azurerm_resource_group.exist_rg.location
  resource_group_name           = data.azurerm_resource_group.exist_rg.name
  disable_bgp_route_propagation = var.aks_route_table.disable_bgp_route_propagation

  dynamic "route" {
    for_each = var.aks_route_table.routes
    content {
      name                   = route.key
      address_prefix         = route.value.address_prefix
      next_hop_type          = route.value.next_hop_type
      next_hop_in_ip_address = try(route.value.next_hop_in_ip_address, null)
    }
  }

  tags = var.resource_tags
}

resource "azurerm_subnet_route_table_association" "association" {
  depends_on = [azurerm_route_table.route_table_aks]

  subnet_id      = data.azurerm_subnet.exist_sn_aks.id
  route_table_id = azurerm_route_table.route_table_aks.id
}