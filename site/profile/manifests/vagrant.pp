#
class profile::vagrant (
  Variant[Undef,String] $version    = undef,
) {

  class { '::vagrant':
    version => $version,
  }

}
