resource "aws_security_group" "postgresql" {
  name   = "postgresql-private-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = var.private_subnets_cidr_blocks
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.hvn_cidr_block]
  }
}

resource "aws_db_instance" "postgresql" {
  identifier             = "${var.env}-${var.service}-psql"
  db_name                = "mydb"
  engine                 = "postgres"
  instance_class         = "db.t3.small"
  allocated_storage      = 5
  vpc_security_group_ids = [aws_security_group.postgresql.id]
  db_subnet_group_name   = var.db_subnet_group_name
  availability_zone      = "us-east-1a"

  username = var.master_username
  password = var.master_password

  backup_retention_period = 5
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
