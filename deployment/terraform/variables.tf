variable "client_id" {}
variable "client_secret" {}
variable "subscription_id" {}
variable "tenant_id" {}

variable "agent_count" {
  default = 2
}

variable "dns_prefix" {
  default = "liatrio"
}

variable cluster_name {
  default = ""
}

variable resource_group_name {
  default = ""
}

variable "subnet_id" {
  default = ""
}

variable location {
  default = "East US 2"
}

variable shortloc {
  default = "eus2"
}

variable env {
  default = "dev"
}

variable k8s_version {
  default = "1.22.6"
}

variable ssh_public_key {
  default = ""
}
variable ssh_key_name {
  default = "ssh_public_key"
}

variable log_analytics_workspace_name {
  default = ""
}

locals {
  log_analytics_workspace_name = (length(var.log_analytics_workspace_name) > 0 ? var.log_analytics_workspace_name : "${var.prefix}${substr(var.env, 0, 1)}01${var.shortloc}la")
  resource_group_name          = (length(var.resource_group_name) > 0 ? var.resource_group_name : azurerm_resource_group.liatrio[0].name)
  cluster_name                 = (length(var.cluster_name) > 0 ? var.cluster_name : "${var.prefix}${substr(var.env, 0, 1)}01${var.shortloc}kc")
  clusterpre                   = "${var.prefix}${substr(var.env, 0, 1)}01${var.shortloc}"
}

variable log_analytics_workspace_location {
  default = "eastus"
}

variable log_analytics_workspace_sku {
  default = "PerGB2018"
}

variable prefix {
  default = ""
}

variable tags {
  default = {
    Environment = "DEV"
    Application = "Liatrio"
  }
}

variable agent_pool_instance_type {}
