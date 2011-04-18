# Class: portmap::absent
#
# Removes portmap package and its relevant monitor, backup, firewall entries
#
# Usage:
# include portmap::absent
#
class portmap::absent {

    require portmap::params

    package { "portmap":
        name   => "${portmap::params::packagename}",
        ensure => absent,
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include portmap::monitor::absent }
    if $backup == "yes" { include portmap::backup::absent }
    if $firewall == "yes" { include portmap::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include portmap::debug }

}
