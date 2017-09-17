# Generic class to remove unnecessary services and packages
#
class psick::hardening::generic (
  Array $packages_to_remove        = [],
  Array $services_to_remove        = [],
  Boolean $remove_default_packages = false,
  Boolean $remove_default_services = false,
) {

  $packages_default = []
  $services_default = $::osfamily ? {
    'RedHat'  => $::operatingsystemmajrelease ? {
      '5'      => [ ],
      '6'      => [ ],
      '7'      => [ ],
      default => [ ],
    },
    'Debian' => $::operatingsystemmajrelease ? {
      '6'      => [ ],
      '7'      => [ ],
      '8'      => [ ],
      '12.04'  => [ ],
      '14.04'  => [ ],
      '16.04'  => [ ],
      default => [ ],
    },
    default  => [ ],
  }

  $packages = $remove_default_packages ? {
    true  => $packages_to_remove + $packages_default,
    false => $packages_to_remove,
  }
  $services = $remove_default_services ? {
    true  => $services_to_remove + $services_default,
    false => $services_to_remove,
  }

  if $packages != [] {
    package { $packages:
      ensure => absent,
    }
  }
  $services.each |$svc| {
    service { $svc:
      ensure => stopped,
      enable => false,
    }
  }

}
