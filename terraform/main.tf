## AWS
module "aws" {
  source    = "./modules/aws"
  count     = var.enable_aws ? 1 : 0
  instances = var.instance_count
  subnet    = var.aws_subnet
}

## Azure
module "azure" {
  source                  = "./modules/azure"
  count                   = var.enable_azure ? 1 : 0
  instances               = var.instance_count
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
}