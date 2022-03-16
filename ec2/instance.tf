resource "aws_instance" "webapp" {
  ami                  = var.ami
  instance_type        = "t3a.micro"
  key_name             = var.key_name
  iam_instance_profile = aws_iam_instance_profile.webapp-profile.name

  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [aws_security_group.webapp.id]
}

resource "aws_security_group" "webapp" {
  name   = "webapp"
  vpc_id = var.vpc_id

  ingress {
    description = "SSH Public Access (bad)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
