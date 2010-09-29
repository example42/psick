# Class: snmpd::firewall
#
# Manages snmpd firewalling using custom Firewall wrapper
# By default it opens snmpd's default port(s) to anybody
# It's automatically included if $firewall=yes
# Note that it uses fact's based $ipaddress as destination IP
# You may need to change it for natted or multihomed hosts
#
# Usage:
# include snmpd::firewall
#
class snmpd::firewall {

    firewall {
        "snmpd_port":
        source        => "any",
        destination => $ipaddress,
        protocol    => "udp",
        port         => 161,
        action      => "allow",
        direction   => "inbound",
    }

}
