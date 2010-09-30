# Class: squid::disable
#
# Stops squid service and disables it at boot time
#
# Usage:
# include squid::disable
#
class squid::disable inherits squid {
    Service["squid"] {
        ensure => "stopped" ,
        enable => "false",
    }
}
