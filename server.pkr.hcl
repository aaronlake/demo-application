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

data "amazon-ami" "ubuntu-focal-east" {
  region = "us-east-1"
  filters = {
    name = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
  }
  most_recent = true
  owners      = ["099720109477"]
}

source "amazon-ebs" "webapp" {
  region         = "us-east-1"
  source_ami     = data.amazon-ami.ubuntu-focal-east.id
  instance_type  = "t2.small"
  ssh_username   = "ubuntu"
  ssh_agent_auth = false
  ami_name       = "packer_AWS_{{timestamp}}_v${var.version}"
}

build {
  hcp_packer_registry {
    bucket_name = "webapp"
    description = "Webapp AMI"
    bucket_labels = {
      "owner"          = "platform-team"
      "os"             = "Ubuntu",
      "ubuntu-version" = "Focal 20.04",
    }

    build_labels = {
      "build-time"   = timestamp()
      "build-source" = basename(path.cwd)
    }
  }
  sources = [
    "source.amazon-ebs.webapp"
  ]

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y postgresql-client",
      "sudo curl \"https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb\" -o \"/tmp/session-manager-plugin.deb\"",
      "sudo dpkg -i /tmp/session-manager-plugin.deb",
      "sudo rm session-manager-plugin.deb"
    ]
  }
}