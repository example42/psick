# Class: openntpd::firewall
#
# Manages openntpd firewalling using custom Firewall wrapper
# By default it opens openntpd's default port(s) to anybody
# It's automatically included if $firewall=yes
# Note that it uses fact's based $ipaddress as destination IP
# You may need to change it for natted or multihomed hosts
#
# Usage:
# include openntpd::firewall
#
class openntpd::firewall {

    firewall {
        "openntpd_port_111_udp":
        source      => "any",
        destination => $ipaddress,
        protocol    => "udp",
        port        => 111,
        action      => "allow",
        direction   => "inbound",
    }

    firewall {
        "openntpd_port_111_tcp":
        source      => "any",
        destination => $ipaddress,
        protocol    => "tcp",
        port        => 111,
        action      => "allow",
        direction   => "inbound",
    }

}
