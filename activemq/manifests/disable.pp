# Class: activemq::disable
#
# Stops activemq service and disables it at boot time
#
# Usage:
# include activemq::disable
#
class activemq::disable inherits activemq {
    Service["activemq"] {
        ensure => "stopped" ,
        enable => "false",
    }
}
