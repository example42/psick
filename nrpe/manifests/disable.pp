# Class: nrpe::disable
#
# Stops nrpe service and disables it at boot time
#
# Usage:
# include nrpe::disable
#
class nrpe::disable inherits nrpe {
    Service["nrpe"] {
        ensure => "stopped" ,
        enable => "false",
    }
}
