# Set the variable value in *.tfvars file
# or using the -var="hcloud_token=..." CLI option
variable "hcloud_token" {
  type        = string
  description = "The 64 digit API token"
}

variable "client_nodes" {
  type        = list
  description = "A list of client nodes to generate the workstations from"
}

variable "sshkey" {
  type = string
  description = "The full path to ssh key file for provisioning. May not have a passphrase and must be added to cloud provider prior usage, e.g. /home/user/.ssh/hetzner_private"
}

# Configure the Hetzner Cloud Provider
provider "hcloud" {
  token   = var.hcloud_token
  version = "~> 1.16"
}

data "hcloud_ssh_keys" "all_keys" {
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
      "/tmp/cloud_master_init.sh",
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
      "/tmp/cloud_gitlab_init.sh",
    ]
  }
}

#resource "hcloud_server" "client_nodes" {
#  for_each    = toset(var.client_nodes)
#  name        = each.value
#  image       = "centos-7"
#  server_type = "cx11"
#  ssh_keys    = data.hcloud_ssh_keys.all_keys.ssh_keys.*.name
#  location    = "fsn1"
#  labels      = { "use" = "schulung" }
#}

# lets get a list of all running servers, a summary would be nice...
#data "hcloud_server" "all_running_servers" {
#  with_selector = "use=schulung"
#  with_status   = ["running"]
#}
