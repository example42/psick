
output "server_ip_list" {
  value = {
    for instance,data in hcloud_server.client_nodes:
      instance => data.ipv4_address
  }
}
