module "vpc"{
  source              ="git::https://github.com/chandralekhasingasani/tf-module-vpc.git"
  CIDR_BLOCK          = var.CIDR_BLOCK
  AZ                  = var.AZ
  ENV                 = var.ENV
  SUBNET_CIDR_BLOCK   = var.SUBNET_CIDR_BLOCK
  COMPONENT           = var.COMPONENT
}


module "rabbitmq" {
  depends_on             = [module.vpc]
  source = "git::https://github.com/chandralekhasingasani/tf-module-rabbitmq.git"
  COMPONENT = "rabbitmq"
  ENV = var.ENV
  SUBNET_IDS = module.vpc.SUBNET_IDS
  VPC_ID = module.vpc.VPC_ID
  CIDR_BLOCK = module.vpc.VPC_CIDR
  INSTANCE_TYPE          = var.INSTANCE_TYPE
  SPOT_INSTANCE_COUNT    = var.SPOT_INSTANCE_COUNT
  INSTANCE_COUNT         = var.INSTANCE_COUNT
  WORKSTATION_IP  = var.WORKSTATION_IP
  PRIVATE_HOSTED_ZONE_ID = module.vpc.PRIVATE_HOSTED_ZONE_ID
  PORT                   = 5672
}

module "app"{
  depends_on             = [module.rabbitmq]
  source                 = "git::https://github.com/chandralekhasingasani/tf-module-mutable.git"
  ENV                    = var.ENV
  COMPONENT              = var.COMPONENT
  VPC_ID                 = module.vpc.VPC_ID
  SUBNET_IDS             = module.vpc.SUBNET_IDS
  CIDR_BLOCK             = module.vpc.VPC_CIDR
  INSTANCE_TYPE          = var.INSTANCE_TYPE
  SPOT_INSTANCE_COUNT    = var.SPOT_INSTANCE_COUNT
  INSTANCE_COUNT         = var.INSTANCE_COUNT
  WORKSTATION_IP         = var.WORKSTATION_IP
  PORT                   = var.PORT
  IAM_INSTANCE_PROFILE   = var.IAM_INSTANCE_PROFILE
  IS_ALB_INTERNAL        = var.IS_ALB_INTERNAL
  CIDR_BLOCK_ELB_ACCESS  = [var.FRONT_END_CIDR, module.vpc.VPC_CIDR,"${module.vpc.NAT_GW_IP}/32"]
  PRIVATE_HOSTED_ZONE_ID = module.vpc.PRIVATE_HOSTED_ZONE_ID
  PROMETHEUS_IP          = var.PROMETHEUS_IP
}



