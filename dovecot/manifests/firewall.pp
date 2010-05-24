# Class: dovecot::firewall
#
# Manages dovecot firewalling using custom Firewall wrapper
# By default it opens dovecot's default port(s) to anybody
# It's automatically included if $firewall=yes
# Note that it uses fact's based $ipaddress as destination IP
# You may need to change it for natted or multihomed hosts
#
# Usage:
# include dovecot::firewall
#
class dovecot::firewall {

    firewall {
        "dovecot_port":
        source        => "any",
        destination => $ipaddress,
        protocol    => "tcp",
        port         => 110,
        action      => "allow",
        direction   => "inbound",
    }

    firewall {
        "dovecot_port":
        source        => "any",
        destination => $ipaddress,
        protocol    => "tcp",
        port         => 143,
        action      => "allow",
        direction   => "inbound",
    }

    firewall {
        "dovecot_port":
        source        => "any",
        destination => $ipaddress,
        protocol    => "tcp",
        port         => 993,
        action      => "allow",
        direction   => "inbound",
    }

    firewall {
        "dovecot_port":
        source        => "any",
        destination => $ipaddress,
        protocol    => "tcp",
        port         => 995,
        action      => "allow",
        direction   => "inbound",
    }

}
