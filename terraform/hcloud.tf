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
}

resource "hcloud_server" "gitlab" {
  name        = "gitlab"
  image       = "centos-7"
  server_type = "cx21"
  ssh_keys    = data.hcloud_ssh_keys.all_keys.ssh_keys.*.name
  location    = "fsn1"
  labels      = { "use" = "schulung" }
}

resource "hcloud_server" "client_nodes" {
  for_each    = toset(var.client_nodes)
  name        = each.value
  image       = "centos-7"
  server_type = "cx11"
  ssh_keys    = data.hcloud_ssh_keys.all_keys.ssh_keys.*.name
  location    = "fsn1"
  labels      = { "use" = "schulung" }
}

#add this to hcloud_server definitions to provision them:
#  provisioner "file" {
#    source      = "script.sh"
#    destination = "/tmp/script.sh"
#  }

#  provisioner "remote-exec" {
#    inline = [
#      "chmod +x /tmp/script.sh",
#      "/tmp/script.sh args",
#    ]
#  }

# lets get a list of all running servers, a summary would be nice...
#data "hcloud_server" "all_running_servers" {
#  with_selector = "use=schulung"
#  with_status   = ["running"]
#}