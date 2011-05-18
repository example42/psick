# Class: dhcpd::absent
#
# Removes dhcpd package and its relevant monitor, backup, firewall entries
#
# Usage:
# include dhcpd::absent
#
class dhcpd::absent {

    require dhcpd::params

    package { "dhcpd":
        name   => "${dhcpd::params::packagename}",
        ensure => absent,
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include dhcpd::monitor::absent }
    if $backup == "yes" { include dhcpd::backup::absent }
    if $firewall == "yes" { include dhcpd::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include dhcpd::debug }

}
