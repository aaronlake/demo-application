packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "version" {
  type    = string
  default = "1.0.0"
}

source "amazon-ami" "ubuntu-focal-east" {
  region = "us-east-1"
  filters = {
    name = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
  }
  most_recent = true
  owners      = ["099720109477"]
}

source "amazon-ebs" "webapp-east" {
  region         = "us-east-1"
  source_ami     = data.amazon-ami.ubuntu-focal-east.id
  instance_type  = "t3a.small"
  ssh_username   = "ubuntu"
  ssh_agent_auth = false
  ami_name       = "packer_AWS_{{timestamp}}_v${var.version}"
}

build {
  hcp_packer_registry {
    bucket_name = "webapp"
    description = "Basic demo webapp."
    bucket_labels = {
      "owner"          = "application-team",
      "os"             = " Ubuntu",
      "ubuntu-version" = "Focal 20.04",
    }

    build_labels = {
      "build-time"   = timestamp()
      "build-source" = basename(path.cwd)
    }
    sources = ["source.amazon-ebs.webapp-east"]

  }
}