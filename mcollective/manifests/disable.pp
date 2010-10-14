# Class: mcollective::disable
#
# Stops mcollective service and disables it at boot time
#
# Usage:
# include mcollective::disable
#
class mcollective::disable inherits mcollective {
    Service["mcollective"] {
        ensure => "stopped" ,
        enable => "false",
    }
}
