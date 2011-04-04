# Class: openvpn::disable
#
# Stops openvpn service and disables it at boot time
# Removes the monitor checks, but not the other extended elements (backup, firewall)
# Use openvpn::absent to remove everything
#
# Usage:
# include openvpn::disable
#
class openvpn::disable inherits openvpn {

    require openvpn::params

    Service["openvpn"] {
        ensure => "stopped" ,
        enable => "false",
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include openvpn::monitor::absent }
    # if $backup == "yes" { include openvpn::backup::absent }
    # if $firewall == "yes" { include openvpn::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include openvpn::debug }

}
