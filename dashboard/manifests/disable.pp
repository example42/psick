# Class: dashboard::disable
#
# Stops dashboard service and disables it at boot time
#
# Usage:
# include dashboard::disable
#
class dashboard::disable inherits dashboard {
    Service["dashboard"] {
        ensure => "stopped" ,
        enable => "false",
    }
}
