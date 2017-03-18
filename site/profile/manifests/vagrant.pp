# This class installs Varant using the unibet/vagrant module
#
# @param version The Vagrant version to install
#
class profile::vagrant (
  Variant[Undef,String] $version    = undef,
) {

  class { '::vagrant':
    version => $version,
  }

}
