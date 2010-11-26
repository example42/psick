# Class: munin::absent
#
# Removes munin package and its relevant monitor, backup, firewall entries
#
# Usage:
# include munin::absent
#
class munin::absent {

    require munin::params

    package { "munin-node":
        name   => "${munin::params::packagename}",
        ensure => absent,
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include munin::monitor::absent }
    if $backup == "yes" { include munin::backup::absent }
    if $firewall == "yes" { include munin::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include munin::debug }


}
