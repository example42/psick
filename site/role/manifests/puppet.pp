# Puppet Master
#
class role::puppet {

  include ::profile::puppet::v4::puppetserver
  include ::profile::puppetdb

}
