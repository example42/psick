# Class: foo::firewall
#
# Manages foo firewalling using custom Firewall wrapper
# By default it opens foo's default port(s) to anybody
# It's automatically included if $firewall=yes
# Note that it uses fact's based $ipaddress as destination IP
# You may need to change it for natted or multihomed hosts
#
# Usage:
# include foo::firewall
#
class foo::firewall {

    firewall {
        "foo_port":
        source        => "any",
        destination => $ipaddress,
        protocol    => "tcp",
        port         => 8140,
        action      => "allow",
        direction   => "inbound",
    }

    firewall {
        "foo_port_":
#        source        => "$ipaddress",
        destination => "any",
        protocol    => "tcp",
        port         => 8140,
        action      => "allow",
        direction   => "outbound",
    }
}
