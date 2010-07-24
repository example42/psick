# Class: puppet::disable
#
# Stops puppet service and disables it at boot time
#
# Usage:
# include puppet::disable
#
class puppet::disable inherits puppet {
    Service["puppet"] {
        ensure => "stopped" ,
        enable => "false",
    }
}
