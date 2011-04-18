# Class: portmap::firewall
#
# Manages portmap firewalling using custom Firewall wrapper
# By default it opens portmap's default port(s) to anybody
# It's automatically included if $firewall=yes
#
# Usage:
# Automatically included if $firewall=yes 
#
class portmap::firewall {

    include portmap::params

    firewall { "portmap_tcp_${portmap::params::port}":
        source      => "${portmap::params::firewall_source_real}",
        destination => "${portmap::params::firewall_destination_real}",
        protocol    => "tcp",
        port        => "${portmap::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "${portmap::params::firewall_enable}",
    }

    # Portmap uses both tcp and udp
    firewall { "portmap_udp_${portmap::params::port}":
        source      => "${portmap::params::firewall_source_real}",
        destination => "${portmap::params::firewall_destination_real}",
        protocol    => "udp",
        port        => "${portmap::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "${portmap::params::firewall_enable}",
    }



}
