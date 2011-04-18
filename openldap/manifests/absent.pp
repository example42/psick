# Class: openldap::absent
#
# Removes openldap package and its relevant monitor, backup, firewall entries
#
# Usage:
# include openldap::absent
#
class openldap::absent {

    require openldap::params

    package { "openldap":
        name   => "${openldap::params::packagename}",
        ensure => absent,
    }

    # Remove relevant monitor, backup, firewall entries
#    if $monitor == "yes" { include openldap::monitor::absent }
#    if $backup == "yes" { include openldap::backup::absent }
#    if $firewall == "yes" { include openldap::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include openldap::debug }

}
