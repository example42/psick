# Class: collectd::disable
#
# Stops collectd service and disables it at boot time
#
# Usage:
# include collectd::disable
#
class collectd::disable inherits collectd {
    Service["collectd"] {
        ensure => "stopped" ,
        enable => "false",
    }
}
