# Class: samba::absent
#
# Removes samba package and its relevant monitor, backup, firewall entries
#
# Usage:
# include samba::absent
#
class samba::absent {

    require samba::params

    package { "samba":
        name   => "${samba::params::packagename}",
        ensure => absent,
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include samba::monitor::absent }
    if $backup == "yes" { include samba::backup::absent }
    if $firewall == "yes" { include samba::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include samba::debug }

}
