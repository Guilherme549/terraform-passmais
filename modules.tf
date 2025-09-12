module "passmais_network" {
  source       = "./modules/network"
  cidr_block   = var.cidr_block
  project_name = var.project_name
  tags         = local.tags
}

module "passmais_ec2" {
  vpc = module.passmais_network.vpc
  source                    = "./modules/ec2"
  project_name              = var.project_name
  tags                      = local.tags
}

module "passmais_ecr" {
  source = "./modules/ecr"

}

module "passmais_ecs" {
  source                    = "./modules/ecs"
  passmais_subnet_public_1a = module.passmais_network.passmais_subnet_public_1a
  passmais_subnet_public_1b = module.passmais_network.passmais_subnet_public_1b
  passmais_sg_id            = module.passmais_ec2.passmais_sg_id
  rds_sg_id                 = module.passmais_rds.rds_sg_id
  ECR_URI_IMAGE             = var.ECR_URI_IMAGE
  ARN_S3_env                = var.ARN_S3_env
  load_balancer_arn         = module.passmais_loadbalancer.load_balancer_arn
  passmais_target_group_arn = module.passmais_target_groups.target_group_arn
  aws_lb_listener_https     = module.passmais_loadbalancer.aws_lb_listener_https
  aws_lb_listener_http      = module.passmais_loadbalancer.aws_lb_listener_http
}

module "passmais_rds" {
  source = "./modules/rds"
  vpc    = module.passmais_network.vpc
  tags                                = local.tags
  passmais_sg_id                        = module.passmais_ec2.passmais_sg_id
}

module "passmais_loadbalancer" {
  source       = "./modules/load_balancer"
  project_name = var.project_name
  tags         = local.tags
  vpc          = module.passmais_network.vpc
  passmais_sg_id = module.passmais_ec2.passmais_sg_id
  db_subnet_ids = [
    module.passmais_network.passmais_subnet_public_1a,
    module.passmais_network.passmais_subnet_public_1b
  ]
  target_group_arn    = module.passmais_target_groups.target_group_arn
  cert_validation_arn = module.passmais_route53.acm_certificate_validated_arn
  record_name         = var.record_name
}

module "passmais_target_groups" {
  source       = "./modules/target-groups"
  project_name = var.project_name
  tags         = local.tags
  vpc          = module.passmais_network.vpc
}

module "passmais_route53" {
  source                 = "./modules/route-53"
  domain_name            = var.domain_name
  record_name            = var.record_name
  load_balancer_dns_name = module.passmais_loadbalancer.load_balancer_dns_name
}