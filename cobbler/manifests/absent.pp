# Class: cobbler::absent
#
# Removes cobbler package and its relevant monitor, backup, firewall entries
#
# Usage:
# include cobbler::absent
#
class cobbler::absent {

    require cobbler::params

    package { "cobbler":
        name   => "${cobbler::params::packagename}",
        ensure => absent,
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include cobbler::monitor::absent }
    if $backup == "yes" { include cobbler::backup::absent }
    if $firewall == "yes" { include cobbler::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include cobbler::debug }

}
