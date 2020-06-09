# Set the variable value in *.tfvars file
# or using the -var="hcloud_token=..." CLI option

terraform {
  experiments = [variable_validation]
}

variable "hcloud_token" {
  type        = string
  description = "The 64 digit API token"
}

variable "client_nodes" {
  type        = list(string)
  description = "A list of client nodes to generate the workstations from"
}

variable "sshkey" {
  type = string
  description = "The full path to ssh key file for provisioning. May not have a passphrase and must be added to cloud provider prior usage, e.g. /home/user/.ssh/hetzner_private"
}

variable "control_repo" {
  type = string
  description = "The control-repo you want to use. Defaults to example42/psick."
  default = "https://github.com/example42/psick.git"
}

variable "puppet_version" {
  type = number
  description = "The Puppet version to use. Specify 5 or 6"
  default = 6
  validation {
    condition = var.puppet_version == 5 || var.puppet_version == 6
    error_message = "The puppet_version variable only accepts value 5 or 6."
  }
}

# Configure the Hetzner Cloud Provider
provider "hcloud" {
  token   = var.hcloud_token
  version = "~> 1.16"
}

data "hcloud_ssh_keys" "all_keys" {
}

resource "hcloud_network" "workshop" {
  name = "workshop"
  ip_range = "10.0.0.0/8"
}

resource "hcloud_network_subnet" "workshop_subnet" {
  network_id = hcloud_network.workshop.id
  type = "server"
  network_zone = "eu-central"
  ip_range   = "10.0.1.0/24"
}

resource "hcloud_server_network" "puppet" {
  server_id = hcloud_server.puppet.id
  network_id = hcloud_network.workshop.id
  ip = "10.0.1.1"
}

resource "hcloud_server_network" "gitlab" {
  server_id = hcloud_server.gitlab.id
  network_id = hcloud_network.workshop.id
  ip = "10.0.1.2"
}

resource "hcloud_server_network" "client_nodes" {
  for_each   = hcloud_server.client_nodes
  server_id  = hcloud_server.client_nodes[each.key].id
  network_id = hcloud_network.workshop.id
  ip = "10.0.1.1[hcloud_server.client_nodes.each.id]"
}

resource "hcloud_server" "puppet" {
  name        = "puppet"
  image       = "centos-7"
  server_type = "cx41"
  ssh_keys    = data.hcloud_ssh_keys.all_keys.ssh_keys.*.name
  location    = "fsn1"
  labels      = { "use" = "schulung" }
  connection {
    type     = "ssh"
    user     = "root"
    private_key = file(var.sshkey)
    host     = self.ipv4_address
  }
  provisioner "file" {
    source      = "../bin/bootstrap/cloud_master_init.sh"
    destination = "/tmp/cloud_master_init.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/cloud_master_init.sh",
      "/tmp/cloud_master_init.sh ${var.puppet_version} ${var.control_repo}",
    ]
  }
}

resource "hcloud_server" "gitlab" {
  name        = "gitlab"
  image       = "centos-7"
  server_type = "cx21"
  ssh_keys    = data.hcloud_ssh_keys.all_keys.ssh_keys.*.name
  location    = "fsn1"
  labels      = { "use" = "schulung" }
  connection {
    type     = "ssh"
    user     = "root"
    private_key = file(var.sshkey)
    host     = self.ipv4_address
  }
  provisioner "file" {
    source      = "../bin/bootstrap/cloud_gitlab_init.sh"
    destination = "/tmp/cloud_gitlab_init.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/cloud_gitlab_init.sh",
      "/tmp/cloud_gitlab_init.sh ${var.puppet_version} ${var.control_repo}",
    ]
  }
}

resource "hcloud_server" "client_nodes" {
  for_each    = toset(var.client_nodes)
  name        = each.value
  image       = "centos-7"
  server_type = "cx11"
  ssh_keys    = data.hcloud_ssh_keys.all_keys.ssh_keys.*.name
  location    = "fsn1"
  labels      = { "use" = "schulung" }
  connection {
    type     = "ssh"
    user     = "root"
    private_key = file(var.sshkey)
    host     = self.ipv4_address
  }
  provisioner "file" {
    source      = "../bin/bootstrap/cloud_student_init.sh"
    destination = "/tmp/cloud_student_init.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/cloud_student_init.sh",
      "/tmp/cloud_student_init.sh ${var.puppet_version} ${var.control_repo}",
    ]
  }
}

output "server_ip_puppet" {
  value = ["${hcloud_server.puppet.ipv4_address}"]
}
output "server_ip_gitlab" {
  value = ["${hcloud_server.gitlab.ipv4_address}"]
}
output "server_ip_clients" {
  value = {
    for instance,data in hcloud_server.client_nodes:
      instance => data.ipv4_address
  }
}
