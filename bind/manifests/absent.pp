# Class: bind::absent
#
# Removes bind package and its relevant monitor, backup, firewall entries
#
# Usage:
# include bind::absent
#
class bind::absent {

    require bind::params

    package { "bind":
        name   => "${bind::params::packagename}",
        ensure => absent,
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include bind::monitor::absent }
    if $backup == "yes" { include bind::backup::absent }
    if $firewall == "yes" { include bind::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include bind::debug }

}
