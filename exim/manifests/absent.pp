# Class: exim::absent
#
# Removes exim package and its relevant monitor, backup, firewall entries
#
# Usage:
# include exim::absent
#
class exim::absent {

    require exim::params

    package { "exim":
        name   => "${exim::params::packagename}",
        ensure => absent,
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include exim::monitor::absent }
    if $backup == "yes" { include exim::backup::absent }
    if $firewall == "yes" { include exim::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include exim::debug }

}
