# Class: apache::disable
#
# Stops apache service and disables it at boot time
#
# Usage:
# include apache::disable

class apache::disable inherits apache {
    Service["apache"] {
        ensure => "stopped" ,
        enable => "false",
    }
}
