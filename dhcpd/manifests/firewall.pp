# Class: dhcpd::firewall
#
# Manages dhcpd firewalling using custom Firewall wrapper
# By default it opens dhcpd's default port(s) to anybody
# It's automatically included if $firewall=yes
#
# Usage:
# Automatically included if $firewall=yes 
#
class dhcpd::firewall {

    include dhcpd::params

    firewall { "dhcpd_${dhcpd::params::protocol}_${dhcpd::params::port}":
        source      => "${dhcpd::params::firewall_source_real}",
        destination => "${dhcpd::params::firewall_destination_real}",
        protocol    => "${dhcpd::params::protocol}",
        port        => "${dhcpd::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "${dhcpd::params::firewall_enable}",
    }

}
