resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name_prefix
  location = var.resource_group_location
}