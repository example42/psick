# This class installs and initialises the Legsto Networker client Software
#
# @param ports_range The ports rang to use when running nsrports
# @param packages The names of the packages to install (default values are
#                 defined for different OS)
#
class psick::backup::legato (
  Array $packages,
  String $ports_range = '7937-8050',
) {

  $packages.each |$pkg| {
    ensure_packages($pkg)
  }

  if $packages != [] {
    service { 'networker':
      ensure => 'running',
      enable => true,
    }

    exec { "nsrports -S ${ports_range}":
      unless  => "nsrports | grep ${ports_range}",
      require => Service['networker'],
    }
  }
}
