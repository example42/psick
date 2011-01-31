# Class: dashboard::firewall
#
# Manages dashboard firewalling using custom Firewall wrapper
# By default it opens dashboard's default port(s) to anybody
# It's automatically included if $firewall=yes
# Note that it uses fact's based $ipaddress as destination IP
# You may need to change it for natted or multihomed hosts
#
# Usage:
# include dashboard::firewall
#
class dashboard::firewall {

    firewall {
        "dashboard_port":
        source        => "0/0",
        destination => $ipaddress,
        protocol    => "tcp",
        port         => 3000,
        action      => "allow",
        direction   => "inbound",
    }

}
