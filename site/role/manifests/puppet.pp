# Puppet Master
#
class role::puppet {

  include ::profile::puppetserver
  include ::profile::puppetdb

}
