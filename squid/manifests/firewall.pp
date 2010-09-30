# Class: squid::firewall
#
# Manages squid firewalling using custom Firewall wrapper
# By default it opens squid's default port(s) to anybody
# It's automatically included if $firewall=yes
#
# Usage:
# Automatically included if $firewall=yes 
#
class squid::firewall {

    include squid::params

    firewall { "squid_${squid::params::protocol}_${squid::params::port}":
        source      => "${squid::params::firewall_source_real}",
        destination => "${squid::params::firewall_destination_real}",
        protocol    => "${squid::params::protocol}",
        port        => "${squid::params::port}",
        action      => "allow",
        direction   => "input",
    }

}
