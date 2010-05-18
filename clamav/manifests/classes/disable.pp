# Class: clamav::disable
#
# Stops clamav service and disables it at boot time
#
# Usage:
# include clamav::disable
#
class clamav::disable inherits clamav {
    Service["clamav"] {
        ensure => "stopped" ,
        enable => "false",
    }
}
