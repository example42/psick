terraform {
  required_providers {
    hetznerdns = {
      source = "timohirt/hetznerdns"
    }
    hcloud = {
      source = "hetznercloud/hcloud"
    }
  }
  required_version = ">= 0.14"
}
