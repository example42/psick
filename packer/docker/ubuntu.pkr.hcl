packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source = "github.com/hashicorp/docker"
    }
  }
}

source "docker" "ubuntu" {
  image  = "ubuntu:xenial"
  commit = true
}

build {
  name    = "docker-tp"
  sources = [
    "source.docker.ubuntu"
  ]
  provisioner "shell" {
    environment_vars = [
      "FOO=hello world",
    ]
    inline = [
      "apt-get update",
      "apt-get install -y wget",
      "wget -O - https://bit.ly/installpuppet | bash",
      "puppet module install example42-tp",
      "puppet tp setup",
      "tp install git",
    ]
  }

   post-processors {
    post-processor "docker-tag" {
        repository =  "example42/ubuntu-tp"
        tag = ["0.1"]
      }
    post-processor "docker-push" {}
  }
}

