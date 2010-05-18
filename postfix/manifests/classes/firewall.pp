# Class: postfix::firewall
#
# Manages postfix firewalling using custom Firewall wrapper
# By default it opens postfix's default port(s) to anybody
# It's automatically included if $firewall=yes
# Note that it uses fact's based $ipaddress as destination IP
# You may need to change it for natted or multihomed hosts
#
# Usage:
# include postfix::firewall
#
class postfix::firewall {

    firewall {
        "postfix_port":
        source        => "any",
        destination => $ipaddress,
        protocol    => "tcp",
        port         => 25,
        action      => "allow",
        direction   => "inbound",
    }

    firewall {
        "postfix_port_":
#        source        => "$ipaddress",
        destination => "any",
        protocol    => "tcp",
        port         => 25,
        action      => "allow",
        direction   => "outbound",
    }
}
