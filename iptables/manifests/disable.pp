# Class: iptables::disable
#
# Stops iptables service and disables it at boot time
# Removes the monitor checks, but not the other extended elements (backup, firewall)
# Use iptables::absent to remove everything
#
# Usage:
# include iptables::disable
#
class iptables::disable inherits iptables::base {

    require iptables::params

    Service["iptables"] {
        ensure => "stopped" ,
        enable => "false",
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include iptables::monitor::absent }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include iptables::debug }

}
