# https://www.terraform.io/docs/providers/azurerm/r/container_registry.html
resource "azurerm_container_registry" "acr" {
  name                     = "${var.registry_name}"
  resource_group_name      = "${azurerm_resource_group.k8s.name}"
  location                 = "${var.location}"
  sku                      = "Basic"
  admin_enabled            = true
}