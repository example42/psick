# Class: openvpn::absent
#
# Removes openvpn package and its relevant monitor, backup, firewall entries
#
# Usage:
# include openvpn::absent
#
class openvpn::absent {

    require openvpn::params

    package { "openvpn":
        name   => "${openvpn::params::packagename}",
        ensure => absent,
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include openvpn::monitor::absent }
    if $backup == "yes" { include openvpn::backup::absent }
    if $firewall == "yes" { include openvpn::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include openvpn::debug }

}
