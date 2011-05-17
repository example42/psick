# Class: virtualbox::absent
#
# Removes virtualbox package and its relevant monitor, backup, firewall entries
#
# Usage:
# include virtualbox::absent
#
class virtualbox::absent {

    require virtualbox::params

    package { "virtualbox":
        name   => "${virtualbox::params::packagename}",
        ensure => absent,
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include virtualbox::monitor::absent }
    if $backup == "yes" { include virtualbox::backup::absent }
    if $firewall == "yes" { include virtualbox::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include virtualbox::debug }

}
