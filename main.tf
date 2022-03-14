data "tfe_outputs" "infrastructure" {
  organization = "Unicorp"
  workspace    = "infrastructure_${var.env}"
}

module "rds" {
  source  = "app.terraform.io/Unicorp/rds/aws"
  version = "1.0.0"

  env                         = var.env
  master_username             = var.master_username
  master_password             = var.master_password
  engine                      = "postgres"
  instance_class              = "db.t3.small"
  db_subnet_group_name        = data.tfe_outputs.infrastructure.values.db_subnet_group_name
  vpc_id                      = data.tfe_outputs.infrastructure.values.vpc_id
  private_subnets_cidr_blocks = data.tfe_outputs.infrastructure.values.private_subnets_cidr_blocks
  hvn_cidr_block              = data.tfe_outputs.infrastructure.values.hvn_cidr_block

  owner   = "dba"
  budget  = "product"
  service = "widgets"
  hipaa   = true
  pii     = true
  ttl     = -1
}
