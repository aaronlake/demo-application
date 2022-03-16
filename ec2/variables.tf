variable "private_subnet_id" {
  description = "The public subnet ID"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "ami" {
  description = "The AMI ID"
  type        = string
}

variable "key_name" {
  description = "SSH key name"
  type        = string
}
