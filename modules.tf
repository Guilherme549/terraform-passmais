module "passmais_network" {
  source       = "./modules/network"
  cidr_block   = var.cidr_block
  project_name = var.project_name
  tags         = local.tags
}

module "passmais_ecr" {
  source = "./modules/ecr"
  
}