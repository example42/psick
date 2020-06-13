# Set the variable value in *.tfvars file
# or using the -var="hcloud_token=..." CLI option

# Configure the Hetzner Cloud Provider
provider "hcloud" {
  token   = var.hcloud_token
  version = "~> 1.16"
}

data "hcloud_ssh_keys" "all_keys" {
}

data "hcloud_ssh_keys" "admin_keys" {
  with_selector = "role=admin"
}

resource "hcloud_network" "workshop" {
  name     = "workshop"
  ip_range = "10.0.0.0/8"
}

resource "hcloud_network_subnet" "workshop_subnet" {
  network_id   = hcloud_network.workshop.id
  type         = "server"
  network_zone = "eu-central"
  ip_range     = "10.0.1.0/24"
}

resource "hcloud_server_network" "nodes" {
  for_each   = var.machines
  server_id  = hcloud_server.client_nodes[each.key].id
  network_id = hcloud_network.workshop.id
  ip         = each.value.ip
}

resource "hcloud_server" "client_nodes" {
  for_each    = var.machines
  name        = each.key
  image       = "centos-7"
  server_type = each.value.server_type
  ssh_keys    = data.hcloud_ssh_keys.all_keys.ssh_keys.*.name
  #ssh_keys    = format("data.hcloud_ssh_keys.%s.ssh_keys.*.name", each.value.access_level)
  location    = "fsn1"
  labels      = { "use" = "schulung" }
  connection {
    type        = "ssh"
    user        = "root"
    private_key = file(var.sshkey)
    host        = self.ipv4_address
  }
  provisioner "file" {
    source      = "../bin/bootstrap/cloud_init.sh"
    destination = "/tmp/cloud_init.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/cloud_init.sh",
      "/tmp/cloud_init.sh ${var.puppet_version} ${each.value.role} ${var.control_repo}",
    ]
  }
}

