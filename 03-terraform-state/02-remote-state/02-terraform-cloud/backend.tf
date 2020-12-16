
#Set up remote state
terraform {
  backend "remote" {
    organization = "lukelabdemo"

    workspaces {
      name = "terraformdemo"
    }
  }
}