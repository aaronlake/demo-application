locals {
  common_tags = {
    env       = var.env
    terraform = true
  }
}

variable "env" {
  description = "Environment (dev, qa, test, prod)"
  type        = string
}

variable "region" {
  description = "AWS Region"
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
