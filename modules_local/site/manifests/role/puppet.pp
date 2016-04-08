# Puppet Master
#
class site::role::puppet {

  include ::profile::puppetserver
  include ::profile::puppetdb

}
