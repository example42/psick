# Class: openssh::disable
#
# Stops openssh service and disables it at boot time
#
# Usage:
# include openssh::disable
#
class openssh::disable inherits openssh {
    Service["openssh"] {
        ensure => "stopped" ,
        enable => "false",
    }
}
