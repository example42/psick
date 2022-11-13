packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source = "github.com/hashicorp/docker"
    }
  }
}

variable "docker_username" {
  type        = string
  description = "The username to access Docker HUB to push images."
}
variable "docker_password" {
  type        = string
  description = "The password to access Docker HUB to push images."
}

source "docker" "ubuntu2204" {
  image  = "ubuntu:22.04"
  commit = true
}
source "docker" "ubuntu2004" {
  image  = "ubuntu:20.04"
  commit = true
}
source "docker" "ubuntu1804" {
  image  = "ubuntu:18.04"
  commit = true
}
source "docker" "debian11" {
  image  = "debian:11"
  commit = true
}
source "docker" "debian10" {
  image  = "debian:10"
  commit = true
}
source "docker" "debian9" {
  image  = "debian:9"
  commit = true
}
source "docker" "debian8" {
  image  = "debian:8"
  commit = true
}
source "docker" "redhat9" {
  image  = "redhat/ubi9-minimal"
  commit = true
}
source "docker" "redhat8" {
  image  = "redhat/ubi8-minimal"
  commit = true
}
source "docker" "redhat7" {
  image  = "lijinguo/redhat7.4"
  commit = true
}
source "docker" "almalinux9" {
  image  = "almalinux:9-minimal"
  commit = true
}
source "docker" "almalinux8" {
  image  = "almalinux:8-minimal"
  commit = true
}
source "docker" "rockylinux9" {
  image  = "rockylinux:9-minimal"
  commit = true
}
source "docker" "rockylinux8" {
  image  = "rockylinux:8-minimal"
  commit = true
}
source "docker" "centos8" {
  image  = "centos:8"
  commit = true
}
source "docker" "centos7" {
  image  = "centos:7"
  commit = true
}
source "docker" "centos6" {
  image  = "centos:6"
  commit = true
}
source "docker" "opensuse15" {
  image  = "opensuse/leap:15"
  commit = true
}

build {
  name    = "docker-tinypuppet"
  sources = [
    "source.docker.ubuntu2204",
    "source.docker.ubuntu2004",
    "source.docker.ubuntu1804",
    "source.docker.debian11",
    "source.docker.debian10",
    "source.docker.debian9",
    "source.docker.debian8",
    "source.docker.redhat9",
    "source.docker.redhat8",
    "source.docker.redhat7",
    "source.docker.almalinux9",
    "source.docker.almalinux8",
    "source.docker.rockylinux9",
    "source.docker.rockylinux8",
    "source.docker.centos8",
    "source.docker.centos7",
    "source.docker.centos6",
    "source.docker.opensuse15",
  ]
  provisioner "shell" {
    inline = [
      "apt-get update && apt-get install -y wget"
    ]
    only = [
      "docker.ubuntu2204",
      "docker.ubuntu2004",
      "docker.ubuntu1804",
      "docker.debian11",
      "docker.debian10",
      "docker.debian9",
      "docker.debian8",
    ]
  }
  provisioner "shell" {
    inline = [
      "microdnf install -y wget yum hostname",
    ]
    only = [
      "docker.almalinux9",
      "docker.almalinux8",
      "docker.rockylinux9",
      "docker.rockylinux8",
      "docker.redhat9",
      "docker.redhat8",
    ]
  }

  # Brutal patch of yum repos for EOL CentOS 6
  provisioner "shell" {
    inline = [
      "curl https://www.getpagespeed.com/files/centos6-eol.repo --output /etc/yum.repos.d/CentOS-Base.repo",
    ]
    only = [
      "docker.centos6",
    ]
  }

  provisioner "shell" {
    inline = [
      "yum install -y wget"
    ]
    only = [
      "docker.centos8",
      "docker.redhat7",
      "docker.centos7",
      "docker.centos6",
    ]
  }

  provisioner "shell" {
    inline = [
      "zypper install -y wget"
    ]
    only = [
      "docker.opensuse15",
    ]
  }

  provisioner "shell" {
    scripts = [
      "bin/puppet_install.sh",
      "bin/tp_setup.sh"
    ]
    valid_exit_codes = [0, 2]
  }
  provisioner "shell" {
    inline = [
      "tp install git"
    ]
    valid_exit_codes = [0, 2]
  }

  post-processors {
    post-processor "docker-tag" {
      repository =  "example42/tiny-puppet-${source.name}"
      tag = ["latest"]
    }
    post-processor "docker-push" {
      login = true
      login_username = "${var.docker_username}"
      login_password = "${var.docker_password}"
    }
  }

}
