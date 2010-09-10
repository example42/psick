# Class: nfs::firewall
#
# Manages nfs firewalling using custom Firewall wrapper
# By default it opens nfs's default port(s) to anybody
# It's automatically included if $firewall=yes
# Note that it uses fact's based $ipaddress as destination IP
# You may need to change it for natted or multihomed hosts
#
# Usage:
# include nfs::firewall
#
class nfs::firewall {

    firewall {
        "nfs_port_2049_udp":
        source      => "any",
        destination => $ipaddress,
        protocol    => "udp",
        port        => 2049,
        action      => "allow",
        direction   => "inbound",
    }

    firewall {
        "nfs_port_2049_tcp":
        source      => "any",
        destination => $ipaddress,
        protocol    => "tcp",
        port        => 2049,
        action      => "allow",
        direction   => "inbound",
    }

# TODO: Add extra ports
}
