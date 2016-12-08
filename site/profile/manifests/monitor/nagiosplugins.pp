# Nagios plugins installation
#
class profile::monitor::nagiosplugins (
  Enum['present','absent'] $ensure = present,
) {

  ::tp::install { 'nagios-plugins':
    ensure => $ensure,
  }

}

