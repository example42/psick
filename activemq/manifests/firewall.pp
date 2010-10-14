# Class: activemq::firewall
#
# Manages activemq firewalling using custom Firewall wrapper
# By default it opens activemq's default port(s) to anybody
# It's automatically included if $firewall=yes
#
# Usage:
# Automatically included if $firewall=yes 
#
class activemq::firewall {

    include activemq::params

    firewall { "activemq_${activemq::params::protocol}_${activemq::params::port}":
        source      => "${activemq::params::firewall_source_real}",
        destination => "${activemq::params::firewall_destination_real}",
        protocol    => "${activemq::params::protocol}",
        port        => "${activemq::params::port}",
        action      => "allow",
        direction   => "input",
    }

}
