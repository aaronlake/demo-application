terraform {
  backend "remote" {
    organization = "Unicorp"

    workspaces {
      prefix = "generate_unicorns_"
    }
  }
}
