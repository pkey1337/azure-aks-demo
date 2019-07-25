resource "azurerm_resource_group" "k8s" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
}

resource "azurerm_log_analytics_workspace" "test" {
  name                = "${var.log_analytics_workspace_name}"
  location            = "${var.log_analytics_workspace_location}"
  resource_group_name = "${azurerm_resource_group.k8s.name}"
  sku                 = "${var.log_analytics_workspace_sku}"
}

resource "azurerm_log_analytics_solution" "test" {
  solution_name         = "ContainerInsights"
  location              = "${azurerm_log_analytics_workspace.test.location}"
  resource_group_name   = "${azurerm_resource_group.k8s.name}"
  workspace_resource_id = "${azurerm_log_analytics_workspace.test.id}"
  workspace_name        = "${azurerm_log_analytics_workspace.test.name}"

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}

# https://www.terraform.io/docs/providers/azurerm/r/kubernetes_cluster.html
resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "${var.cluster_name}"
  location            = "${azurerm_resource_group.k8s.location}"
  resource_group_name = "${azurerm_resource_group.k8s.name}"
  dns_prefix          = "${var.dns_prefix}"

  linux_profile {
    admin_username = "${var.default-admin-user}"

    ssh_key {
      key_data = "${file("${var.ssh_public_key}")}"
    }
  }

  network_profile {
    network_plugin = "azure"
    dns_service_ip = "10.2.0.10"
    docker_bridge_cidr = "172.17.0.1/16"
    service_cidr = "10.2.0.0/24"
  }

  agent_pool_profile {
    name            = "agentpool"
    count           = "${var.agent_count}"
    vm_size         = "Standard_B2s"
    os_type         = "Linux"
    os_disk_size_gb = 30
    vnet_subnet_id = "${var.cluster_agent_vnet_subnetid}"
  }

  service_principal {
    client_id     = "${var.client_id}"
    client_secret = "${var.client_secret}"
  }

  addon_profile {
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = "${azurerm_log_analytics_workspace.test.id}"
    }
  }

}