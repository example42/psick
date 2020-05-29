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
    client_nodes = ["stud1", "stud2", "stud3"]
    sshkey = "/home/example42/.ssh/hetzner_key"

Within `client_nodes` you can specify a list of additional nodes as a comma separated list.

The `sshkey` setting tells terraform where to find the private ssh key without passphrase used for provisioning.


## Finishing

After running `terrafrom apply` you will see a list of servernames and IP addresses.
You still must tell all nodes, where to find the Puppet server by adding an entry to `/etc/hosts`.

