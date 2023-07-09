variable "CIDR_BLOCK" {}
variable "SUBNET_CIDR_BLOCK" {}
variable "COMPONENT" {}
variable "ENV" {}
variable "AZ" {}
variable "PORT" {}
variable "SPOT_INSTANCE_COUNT" {}
variable "INSTANCE_COUNT" {}
variable "INSTANCE_TYPE" {}
variable "WORKSTATION_IP" {}
variable "IAM_INSTANCE_PROFILE" {}
variable "IS_ALB_INTERNAL" {
  default = true
}

variable "FRONT_END_CIDR" {}
