
module "networking" {
  source      = "./modules/networking"
  environment = var.environment

}

module "kms" {
  source = "./modules/kms"

  environment = var.environment
}

module "alb" {
  source = "./modules/alb"

  environment    = var.environment
  vpc_id         = module.networking.vpc_id
  public_subnets = module.networking.public_subnets
}

module "ecs" {
  source = "./modules/ecs"

  environment           = var.environment
  app_name              = var.app_name
  aws_region            = var.aws_region
  vpc_id                = module.networking.vpc_id
  private_subnets       = module.networking.public_subnets
  alb_target_group_arn  = module.alb.target_group_arn
  alb_security_group_id = module.alb.alb_security_group
  alb_listener_arn      = module.alb.alb_listener_arn
  kms_key_arn           = module.kms.key_arn
  kms_policy_arn        = module.kms.policy_arn

  # Optional variables with defaults
}

module "monitoring" {
  source = "./modules/monitoring"

  environment    = var.environment
  app_name       = var.app_name
  aws_region     = var.aws_region
  cluster_name   = module.ecs.cluster_name
  service_name   = module.ecs.service_name
  kms_key_arn    = module.kms.key_arn
  kms_policy_arn = module.kms.policy_arn

  log_retention_days = 30
}

