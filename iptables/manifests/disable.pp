# Class: iptables::disable
#
# Stops iptables service and disables it at boot time
# Removes the monitor checks, but not the other extended elements (backup, firewall)
# Use iptables::absent to remove everything
#
# Usage:
# include iptables::disable
#
class iptables::disable {

    require iptables::params

    service { "iptables":
        ensure => "stopped" ,
        enable => "false",
    }

}
