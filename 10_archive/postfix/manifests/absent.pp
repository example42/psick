# Class: postfix::absent
#
# Removes postfix package and its relevant monitor, backup, firewall entries
#
# Usage:
# include postfix::absent
#
class postfix::absent {

    require postfix::params

    package { "postfix":
        name   => "${postfix::params::packagename}",
        ensure => absent,
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include postfix::monitor::absent }
    if $backup == "yes" { include postfix::backup::absent }
    if $firewall == "yes" { include postfix::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include postfix::debug }


}
