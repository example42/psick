# Class: monit::disable
#
# Stops monit service and disables it at boot time
#
# Usage:
# include monit::disable

class monit::disable inherits monit {
    Service["monit"] {
        ensure => "stopped" ,
        enable => "false",
    }
}
