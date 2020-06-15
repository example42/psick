# PSICK on Hetzner Cloud using Terraform

## Description

This terraform project generates a Puppet Infrastructure on Hetzner Cloud.

We usually use this setup for training classes.

We will always deploy a Puppet Master and a GitLab Server.
Additional Puppet nodes can be specified within the configuration file.

## Preparation

Part 1: Hetzner:

Log into Hetzner Cloud, create a Project, generate an API token and add your SSH Keys, which you want to distribute onto the cloud servers.


Part 2: local:

Generate an SSH Key without (!) passphrase. THis key will be used for provisioning.

Generate file `secrets.auto.tfvars` right next to `hcloud.tf` file.
Content:

    hcloud_token = "your_api_token"
    sshkey = "/home/example42/.ssh/hetzner_key"
    puppet_version = 5
    machines = {
      "puppet"    = { ip = "10.0.1.1",  role = 'puppet',    server_type = 'cx41', access_level = 'admin_keys' }
      "gitlab"    = { ip = "10.0.1.2",  role = 'gitlab',    server_type = 'cx21', access_level = 'admin_keys' }
      "student1"  = { ip = "10.0.1.11", role = 'webserver', server_type = 'cx11', access_level = 'all_keys' }
      "<hostname>"  = { ip = "10.0.1.0/24", role = '<puppet role>', server_type = 'hetzner server type', access_level = '[all_keys, admin_keys]' }
    }

Within `client_nodes` you can specify a list of additional nodes as a comma separated list.

The `sshkey` setting tells terraform where to find the private ssh key without passphrase used for provisioning.

The `puppet_version` variable lets you choose which major Puppet version to install. Here we only accept `5` or `6` as valid values.

Under `machines` you place a hash, which describes the systems in your infrastructure:

* ip: IPv4 Address from subnet 10.0.10.0/24 - configured in hcloud.tf
* role: The desired puppet role, will be added to trusted and external facts. can be used for e.g. node classification
* server\_type: The required Hetzner server type.
* access\_level: which ssh keys to use. possible values: all\_keys or admin\_keys - configured in hcloud.tf

## Finishing

After running `terrafrom apply` you will see a list of servernames and IP addresses.
You still must tell all nodes, where to find the Puppet server by adding an entry to `/etc/hosts`.

