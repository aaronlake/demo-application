data "tfe_outputs" "infrastructure" {
  organization = "Unicorp"
  workspace    = "demo-aws-infra-hcp"
}

data "hcp_packer_iteration" "webapp" {
  bucket_name = "webapp"
  channel     = "webapp"
}

data "hcp_packer_image" "webapp" {
  bucket_name    = "webapp"
  cloud_provider = "aws"
  iteration_id   = data.hcp_packer_iteration.webapp.ulid
  region         = "us-east-1"
}
module "rds" {
  source  = "app.terraform.io/Unicorp/rds/aws"
  version = "1.0.1"

  env                         = var.env
  master_username             = var.master_username
  master_password             = var.master_password
  engine                      = "postgres"
  instance_class              = "db.t3.small"
  db_subnet_group_name        = data.tfe_outputs.infrastructure.values.db_subnet_group_name
  vpc_id                      = data.tfe_outputs.infrastructure.values.vpc_id
  private_subnets_cidr_blocks = data.tfe_outputs.infrastructure.values.private_subnets_cidr_blocks
  public_subnets_cidr_blocks  = data.tfe_outputs.infrastructure.values.public_subnets_cidr_blocks
  hvn_cidr_block              = data.tfe_outputs.infrastructure.values.hvn_cidr_block

  owner   = "dba"
  budget  = "product"
  service = "app"
  hipaa   = true
  pii     = true
  ttl     = -1
}

module "ec2" {
  source            = "./ec2"
  ami               = data.hcp_packer_image.webapp.cloud_image_id
  private_subnet_id = data.tfe_outputs.infrastructure.values.private_subnets[0]
  vpc_id            = data.tfe_outputs.infrastructure.values.vpc_id
  key_name          = "webapp"
}
