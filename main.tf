module "rds" {
  source = "./infrastructure/rds"

  env             = var.env
  master_username = var.master_username
  master_password = var.master_password

  owner   = "unicorn_counters"
  budget  = "product"
  service = "unicorn_counters"
  hipaa   = true
  pii     = true
  ttl     = -1
}
