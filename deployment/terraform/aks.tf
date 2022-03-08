resource "azurerm_resource_group" "liatrio" {
  count    = (length(var.resource_group_name) > 0 ? 0 : 1)
  name     = "${local.clusterpre}rg"
  location = var.location
}

resource "azurerm_virtual_network" "liatrio" {
  count               = (length(var.subnet_id) > 0 ? 0 : 1)
  name                = "${local.clusterpre}vn"
  location            = var.location
  address_space       = ["10.0.0.0/16"]
  resource_group_name = azurerm_resource_group.liatrio.name
  
}

resource "azurerm_subnet" "liatrio" {
  count = (length(var.subnet_id) > 0 ? 0 : 1)
  name = "${local.clusterpre}sn"
  resource_group_name  = azurerm_resource_group.liatrio.name
  virtual_network_name = azurerm_virtual_network.liatrio.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "random_id" "log_analytics_workspace_name_suffix" {
  byte_length = 8
}

resource "azurerm_log_analytics_workspace" "liatrio" {
  name                = "${local.log_analytics_workspace_name}-${random_id.log_analytics_workspace_name_suffix.dec}"
  location            = var.log_analytics_workspace_location
  resource_group_name = local.resource_group_name
  sku                 = var.log_analytics_workspace_sku
  tags                = var.tags
}

resource "azurerm_log_analytics_solution" "liatrio" {
  solution_name         = "ContainerInsights"
  location              = azurerm_log_analytics_workspace.liatrio.location
  resource_group_name   = local.resource_group_name
  workspace_resource_id = azurerm_log_analytics_workspace.liatrio.id
  workspace_name        = azurerm_log_analytics_workspace.liatrio.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}

resource "azurerm_kubernetes_cluster" "liatrio" {
  name                = local.cluster_name
  kubernetes_version  = var.k8s_version
  location            = var.location
  resource_group_name = local.resource_group_name
  dns_prefix          = var.dns_prefix
  tags                = var.tags
  
  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = var.ssh_public_key
    }
  }
  
  network_profile {
    network_plugin     = "azure"
    service_cidr       = "10.0.0.0/16"
    dns_service_ip     = "10.0.0.10"
    docker_bridge_cidr = "172.17.0.1/16"
    
  }
  
  default_node_pool {
    name            = "${var.prefix}${lower(substr(var.env, 0, 1))}1${var.shortloc}"
    node_count      = var.agent_count
    vm_size         = var.agent_pool_instance_type
    os_disk_size_gb = 50

    vnet_subnet_id = (length(var.subnet_id) > 0 ? var.subnet_id : null)

  }
  
  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }
  
  addon_profile {
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.liatrio.id
    }
  }
}

data "azurerm_subscription" "current" {}