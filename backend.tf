terraform {
  backend "remote" {
    organization = "Unicorp"

    workspaces {
      name = "demo-infrastructure"
    }
  }
}
