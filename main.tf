data "tfe_outputs" "infrastructure" {
  organization = "Unicorp"
  workspace    = "infrastructure_${var.env}"
}

module "rds" {
  source = "./infrastructure/rds"

  env                         = var.env
  master_username             = var.master_username
  master_password             = var.master_password
  db_subnet_group_name        = data.tfe_outputs.infrastructure.values.db_subnet_group_name
  vpc_id                      = data.tfe_outputs.infrastructure.values.vpc_id
  private_subnets_cidr_blocks = data.tfe_outputs.infrastructure.values.private_subnets_cidr_blocks

  owner   = "dba"
  budget  = "product"
  service = "widgets"
  hipaa   = true
  pii     = true
  ttl     = -1
}
