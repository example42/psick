# Set the variable value in *.tfvars file
# or using the -var="hcloud_token=..." CLI option

variable "hcloud_token" {
  type        = string
  description = "The 64 digit API token"
}

variable "hdns_token" {
  type        = string
  description = "The DNS API token"
}

variable "public_subdomain" {
  type        = string
  description = "The public subdomain to use"
  default     = "public"
}

variable "internal_subdomain" {
  type        = string
  description = "The internal  subdomain to use"
  default     = "internal"
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
  description = "The Puppet version to use. Specify 5, 6 or 7"
  default = 7
  validation {
    condition = var.puppet_version == 5 || var.puppet_version == 6 || var.puppet_version == 7
    error_message = "The puppet_version variable only accepts value 5, 6 or 7."
  }
}

variable "machines" {
  type = map
  description = "Hash of IP, Role, HW size to use for student maschines."
  default = {
    "puppet"    = { ip = "10.0.1.1",  role = "puppet",  server_type = "cx41", access_level = "admin_keys", image = "centos-7" }
    "gitlab"    = { ip = "10.0.1.2",  role = "gitlab",  server_type = "cx21", access_level = "admin_keys", image = "centos-7" }
    "student1"  = { ip = "10.0.1.11", role = "student", server_type = "cx11", access_level = "all_keys",   image = "centos-7" }
    "student2"  = { ip = "10.0.1.12", role = "student", server_type = "cx11", access_level = "all_keys",   image = "centos-7" }
    "student3"  = { ip = "10.0.1.13", role = "student", server_type = "cx11", access_level = "all_keys",   image = "centos-7" }
    "student4"  = { ip = "10.0.1.14", role = "student", server_type = "cx11", access_level = "all_keys",   image = "centos-7" }
    "student5"  = { ip = "10.0.1.15", role = "student", server_type = "cx11", access_level = "all_keys",   image = "centos-7" }
    "student6"  = { ip = "10.0.1.16", role = "student", server_type = "cx11", access_level = "all_keys",   image = "centos-7" }
    "student7"  = { ip = "10.0.1.17", role = "student", server_type = "cx11", access_level = "all_keys",   image = "centos-7" }
    "student8"  = { ip = "10.0.1.18", role = "student", server_type = "cx11", access_level = "all_keys",   image = "centos-7" }
    "student9"  = { ip = "10.0.1.19", role = "student", server_type = "cx11", access_level = "all_keys",   image = "centos-7" }
    "student10" = { ip = "10.0.1.20", role = "student", server_type = "cx11", access_level = "all_keys",   image = "centos-7" }
    "student11" = { ip = "10.0.1.21", role = "student", server_type = "cx11", access_level = "all_keys",   image = "centos-7" }
    "student12" = { ip = "10.0.1.22", role = "student", server_type = "cx11", access_level = "all_keys",   image = "centos-7" }
    "student13" = { ip = "10.0.1.23", role = "student", server_type = "cx11", access_level = "all_keys",   image = "centos-7" }
    "student14" = { ip = "10.0.1.24", role = "student", server_type = "cx11", access_level = "all_keys",   image = "centos-7" }
    "student15" = { ip = "10.0.1.25", role = "student", server_type = "cx11", access_level = "all_keys",   image = "centos-7" }
  }
}
