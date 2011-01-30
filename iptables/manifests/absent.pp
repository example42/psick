# Class: iptables::absent
#
# Removes iptables package and its relevant monitor, backup, firewall entries
#
# Usage:
# include iptables::absent
#
class iptables::absent {

    require iptables::params

    package { "iptables":
        name   => "${iptables::params::packagename}",
        ensure => absent,
    }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include iptables::debug }

}
