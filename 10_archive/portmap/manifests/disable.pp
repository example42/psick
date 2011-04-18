# Class: portmap::disable
#
# Stops portmap service and disables it at boot time
#
# Usage:
# include portmap::disable
#
class portmap::disable inherits portmap {
    Service["portmap"] {
        ensure => "stopped" ,
        enable => "false",
    }
}
