terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.9"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~>2.7"
    }
    tls = {
      source = "hasicorp/tls"
      version = "~>3.1"
    }
  }
}
provider "azurerm" { 
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  features {}
}

provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.liatrio.kube_config.0.host
  username               = azurerm_kubernetes_cluster.liatrio.kube_config.0.username
  password               = azurerm_kubernetes_cluster.liatrio.kube_config.0.password
  client_certificate     = base64decode(azurerm_kubernetes_cluster.liatrio.kube_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.liatrio.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.liatrio.kube_config.0.cluster_ca_certificate)
  features {}
}