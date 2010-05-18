# Class: mysql::firewall
#
# Manages mysql firewalling using custom Firewall wrapper
# By default it opens mysql's default port(s) to anybody
# It's automatically included if $firewall=yes
# Note that it uses fact's based $ipaddress as destination IP
# You may need to change it for natted or multihomed hosts
#
# Usage:
# include mysql::firewall
#
class mysql::firewall {

    firewall {
        "mysql_port":
        source        => "any",
        destination => $ipaddress,
        protocol    => "tcp",
        port         => 3306,
        action      => "allow",
        direction   => "inbound",
    }

}
