# Class: puppet::firewall
#
# Manages puppet firewalling using custom Firewall wrapper
# By default it opens puppet's default port(s) to anybody
# It's automatically included if $firewall=yes
#
# Usage:
# Automatically included if $firewall=yes 
#
class puppet::firewall {

    include puppet::params

    firewall { "puppet_${puppet::params::protocol}_${puppet::params::port}":
        source      => "${puppet::params::firewall_source_real}",
        destination => "${puppet::params::firewall_destination_real}",
        protocol    => "${puppet::params::protocol}",
        port        => "${puppet::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "${puppet::params::firewall_enable}",
    }

}
