# Class: puppet::firewall
#
# Manages puppet firewalling using custom Firewall wrapper
# By default it opens puppet's default port(s) to anybody
# It's automatically included if $firewall=yes
# Note that it uses fact's based $ipaddress as destination IP
# You may need to change it for natted or multihomed hosts
#
# Usage:
# include puppet::firewall
#
class puppet::firewall {

    firewall {
        "puppet_port":
        source        => "any",
        destination => $ipaddress,
        protocol    => "tcp",
        port         => 8140,
        action      => "allow",
        direction   => "inbound",
    }

    firewall {
        "puppet_port_":
#        source        => "$ipaddress",
        destination => "any",
        protocol    => "tcp",
        port         => 8140,
        action      => "allow",
        direction   => "outbound",
    }
}
