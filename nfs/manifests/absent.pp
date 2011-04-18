# Class: nfs::absent
#
# Removes nfs package and its relevant monitor, backup, firewall entries
#
# Usage:
# include nfs::absent
#
class nfs::absent {

    require nfs::params

    package { "nfs":
        name   => "${nfs::params::packagename}",
        ensure => absent,
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include nfs::monitor::absent }
    if $backup == "yes" { include nfs::backup::absent }
    if $firewall == "yes" { include nfs::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include nfs::debug }

}
