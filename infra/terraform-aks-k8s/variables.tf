variable "client_id" {
  default = ""
}
variable "client_secret" {
  default = ""
}

variable "agent_count" {
  default = 1
}

variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}

variable "dns_prefix" {
  default = ""
}

variable cluster_name {
  default = ""
}

variable registry_name {
  default = ""
}

# when using an existing vnet
# https://docs.microsoft.com/de-de/azure/aks/configure-azure-cni
# https://www.terraform.io/docs/providers/azurerm/r/kubernetes_cluster.html#network_plugin
variable cluster_agent_vnet_subnetid {
  default = ""
}

variable resource_group_name {
  default = ""
}

variable location {
  default = "West Europe"
}

variable log_analytics_workspace_name {
  default = ""
}

# refer https://azure.microsoft.com/global-infrastructure/services/?products=monitor for log analytics available regions
variable log_analytics_workspace_location {
  default = "westeurope"
}

# refer https://azure.microsoft.com/pricing/details/monitor/ for log analytics pricing
variable log_analytics_workspace_sku {
  default = "PerGB2018"
}

variable "default-admin-user" {
  default = ""
}