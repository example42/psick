# Class: activemq::absent
#
# Removes activemq package
#
# Usage:
# include activemq::absent
#
class activemq::absent inherits activemq {
    Package["activemq"] {
        ensure => "absent" ,
    }
}
