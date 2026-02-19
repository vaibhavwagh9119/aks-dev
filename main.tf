
locals {
  prefix = "tsp-fcb-ops-${var.environment}"

  common_tags = {
    Business = "FCB"
    System   = "Ops"
    Env      = var.environment
  }
}

module "rg" {
  source   = "./modules/resource-group"
  name     = "${local.prefix}-rg"
  location = var.location
  tags     = local.common_tags
}

module "network" {
  source              = "./modules/network"
  name                = "${local.prefix}-vnet"
  location            = var.location
  resource_group_name = module.rg.name
  vnet_cidr           = var.vnet_cidr
  subnet_cidr         = var.aks_subnet_cidr
  tags                = local.common_tags
}

module "keyvault" {
  vnet_id = module.network.vnet_id
  private_endpoint_subnet_id = module.network.private_endpoint_subnet_id
  source              = "./modules/keyvault"
  name                = "tspfcbbops${var.environment}kv"
  location            = var.location
  resource_group_name = module.rg.name
  tags                = local.common_tags
}

module "aks" {
  source              = "./modules/aks"
  name                = "${local.prefix}-aks"
  location            = var.location
  resource_group_name = module.rg.name
  subnet_id           = module.network.subnet_id
  keyvault_id         = module.keyvault.id
  tags                = local.common_tags
}
