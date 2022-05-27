# Module OSDU Azure Virtual Network Existing

A terraform module that assists with the provisioning of OSDU, enabling the use of existing virtual networks

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.10 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.90.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 2.90.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_route_table.route_table_aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |
| [azurerm_subnet_route_table_association.association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |
| [azurerm_resource_group.exist_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.exist_sn_aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.exist_sn_fe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_virtual_network.exist_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks_route_table"></a> [aks\_route\_table](#input\_aks\_route\_table) | Map of AKS route table | <pre>object({<br>    route_table_name              = string<br>    disable_bgp_route_propagation = bool<br>    use_inline_routes             = bool # Setting to true will revert any external route additions.<br>    routes                        = map(map(string))<br>    # keys are route names, value map is route properties (address_prefix, next_hop_type, next_hop_in_ip_address)<br>    # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table#route<br>  })</pre> | `{}` | no |
| <a name="input_existing_resource_group_name"></a> [existing\_resource\_group\_name](#input\_existing\_resource\_group\_name) | The name of the existing resource group containing the virtual network. | `string` | n/a | yes |
| <a name="input_existing_subnet_name_aks"></a> [existing\_subnet\_name\_aks](#input\_existing\_subnet\_name\_aks) | The name of the existing subnet for AKS. | `string` | n/a | yes |
| <a name="input_existing_subnet_name_fe"></a> [existing\_subnet\_name\_fe](#input\_existing\_subnet\_name\_fe) | The name of the existing subnet for FE. | `string` | n/a | yes |
| <a name="input_existing_vnet_name"></a> [existing\_vnet\_name](#input\_existing\_vnet\_name) | The name of the existing virtual network. | `string` | n/a | yes |
| <a name="input_resource_tags"></a> [resource\_tags](#input\_resource\_tags) | Map of tags to apply to taggable resources in this module. By default the taggable resources are tagged with the name defined above and this map is merged in | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aks_rt"></a> [aks\_rt](#output\_aks\_rt) | Object containing AKS route table information. |
| <a name="output_aks_sn_id"></a> [aks\_sn\_id](#output\_aks\_sn\_id) | Subnet data object. |
| <a name="output_exist_vnet_id"></a> [exist\_vnet\_id](#output\_exist\_vnet\_id) | Virtual network id. |
| <a name="output_exist_vnet_name"></a> [exist\_vnet\_name](#output\_exist\_vnet\_name) | Virtual network name. |
| <a name="output_fe_sn_id"></a> [fe\_sn\_id](#output\_fe\_sn\_id) | Subnet data object. |
<!-- END_TF_DOCS -->