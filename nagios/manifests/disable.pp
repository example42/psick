# Class: nagios::disable
#
# Stops nagios service and disables it at boot time
#
# Usage:
# include nagios::disable
#
class nagios::disable inherits nagios {
    Service["nagios"] {
        ensure => "stopped" ,
        enable => "false",
    }
}
