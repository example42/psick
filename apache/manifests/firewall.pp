# Class: apache::firewall
#
# Manages apache firewalling using custom Firewall wrapper
# By default it opens apache's default port(s) to anybody
# It's automatically included if $firewall=yes
# Note that it uses fact's based $ipaddress as destination IP
# You may need to change it for natted or multihomed hosts
#
# Usage:
# include apache::firewall
#
class apache::firewall {

    firewall {
        "apache_port":
        source        => "any",
        destination => $ipaddress,
        protocol    => "tcp",
        port         => 80,
        action      => "allow",
    }

}
