# Class: puppet::server::disable
#
# Stops puppetmaster service and disables it at boot time
#
# Usage:
# include puppet::server::disable
#
class puppet::server::disable inherits puppet::server {
    Service["puppetmaster"] {
        ensure => "stopped" ,
        enable => "false",
    }
}

