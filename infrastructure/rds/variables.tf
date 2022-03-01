variable "env" {
  description = "The environment to deploy to"
  type        = string
}

variable "vpc_id" {
  description = "The VPC to deploy to"
  type        = string
}

variable "master_username" {
  description = "The master username for the DB instance."
  type        = string
}

variable "master_password" {
  description = "The master password for the DB instance."
  type        = string
}

variable "db_subnet_group_name" {
  description = "The name of the DB subnet group to use."
  type        = string
}

variable "private_subnets_cidr_blocks" {
  description = "The private subnets CIDR blocks to use."
  type        = list(string)
}

# Required Tags
########################

locals {
  common_tags = {
    env       = var.env
    terraform = true
  }
}

variable "owner" {
  description = "Owner of the resource"
  type        = string
}

variable "budget" {
  description = "Team responsible for the resource"
  type        = string
}

variable "service" {
  description = "Service offering"
  type        = string
}

variable "hipaa" {
  description = "HIPAA compliance"
  type        = bool
}

variable "pii" {
  description = "PII compliance"
  type        = bool
}

variable "ttl" {
  description = "Hours before the resource expires. *Use -1 for indefinite.*"
  type        = string
  default     = "168"
}

