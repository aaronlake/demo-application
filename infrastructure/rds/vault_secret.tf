resource "vault_mount" "db" {
  path = "postgres"
  type = "database"
}

resource "vault_database_secret_backend_connection" "postgres" {
  backend       = vault_mount.db.path
  name          = aws_db_instance.postgresql.name
  allowed_roles = ["*"]

  postgresql {
    connection_url = "postgresql://${var.master_username}:${var.master_password}@${aws_db_instance.postgresql.endpoint}/${aws_db_instance.postgresql.db_name}"
  }

  depends_on = [aws_db_instance.postgresql]
}

resource "vault_database_secret_backend_role" "role" {
  for_each = toset(var.entities)
  backend  = vault_mount.db.path
  name     = each.key
  db_name  = vault_database_secret_backend_connection.postgres.name
  creation_statements = [
    "CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';",
    "GRANT SELECT ON ALL TABLES IN SCHEMA public TO \"{{name}}\";"
  ]
  revocation_statements = ["ALTER ROLE \"{{name}}\" NOLOGIN;"]
  default_ttl           = var.postgres_ttl
  max_ttl               = 300
}
