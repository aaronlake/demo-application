# resource "vault_mount" "db" {
#   path = "postgres"
#   type = "database"
# }

# resource "vault_database_secret_backend_connection" "postgres" {
#   backend       = vault_mount.db.path
#   name          = "postgres"
#   allowed_roles = ["*"]

#   postgresql {
#     connection_url = aws_rds_cluster.postgresql.endpoint
#   }
# }
