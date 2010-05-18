# Class: clamav::firewall
#
# Manages clamav firewalling using custom Firewall wrapper
# By default it opens clamav's default port(s) to anybody
# It's automatically included if $firewall=yes
# Note that it uses fact's based $ipaddress as destination IP
# You may need to change it for natted or multihomed hosts
#
# Usage:
# include clamav::firewall
#
class clamav::firewall {

    firewall {
        "clamav_port":
        source        => "any",
        destination => $ipaddress,
        protocol    => "tcp",
        port         => 25,
        action      => "allow",
        direction   => "inbound",
    }

    firewall {
        "clamav_port_":
#        source        => "$ipaddress",
        destination => "any",
        protocol    => "tcp",
        port         => 25,
        action      => "allow",
        direction   => "outbound",
    }
}
