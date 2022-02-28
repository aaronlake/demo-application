data "tfe_outputs" "infrastructure" {
  organization = "Unicorp"
  workspace    = "infrastructure_${var.env}"
}
resource "aws_rds_cluster" "postgresql" {
  cluster_identifier   = "${var.env}-${var.service}-psql"
  database_name        = "mydb"
  engine               = "aurora-postgresql"
  db_subnet_group_name = data.tfe_outputs.infrastructure.values.db_subnet_group_name
  availability_zones   = ["us-east-1a", "us-east-1b"]
  master_username      = var.master_username
  master_password      = var.master_password

  backup_retention_period = 5
  preferred_backup_window = "05:00-07:00"
  skip_final_snapshot     = true

  tags = merge(local.common_tags, {
    owner   = var.owner
    budget  = var.budget
    service = var.service
    hipaa   = var.hipaa
    pii     = var.pii
    ttl     = -1
  })
}
