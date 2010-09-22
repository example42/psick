# Class: exim::disable
#
# Stops exim service and disables it at boot time
#
# Usage:
# include exim::disable
#
class exim::disable inherits exim {
    Service["exim"] {
        ensure => "stopped" ,
        enable => "false",
    }
}
