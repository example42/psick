# Class: autofs::disable
#
# Stops autofs service and disables it at boot time
#
# Usage:
# include autofs::disable
#
class autofs::disable inherits autofs {
    Service["autofs"] {
        ensure => "stopped" ,
        enable => "false",
    }
}
