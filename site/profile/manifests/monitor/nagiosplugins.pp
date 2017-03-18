# This class installs Nagios plugins using tp
#
class profile::monitor::nagiosplugins (
  Variant[Boolean,String] $ensure = present,
  Boolean     $auto_prerequisites = true,
) {

  ::tp::install { 'nagios-plugins':
    ensure             => $ensure,
    auto_prerequisites => $auto_prerequisites,
  }

}
