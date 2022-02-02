resource "azurerm_resource_group" "resource_group1" {
  name      = "${var.environment}-${var.resource_group_name}"
  location  = var.location
}


module "vnet" {
  source                = "./modules/1-vnet"
  location              = var.location
  resource_group_name   = azurerm_resource_group.resource_group1.name
  environment           = var.environment
}

module "vms" {
  source                = "./modules/2-vms"
  location              = var.location
  resource_group_name   = azurerm_resource_group.resource_group1.name
  subnet_id             = module.vnet.subnet_id
}

module "sql" {
  source                = "./modules/3-sql"
  location              = var.location
  resource_group_name   = azurerm_resource_group.resource_group1.name
}


# To provision on model: terraform plan --target=module.<declared module name>
# NB: 2 --  !!