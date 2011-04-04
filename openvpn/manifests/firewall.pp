# Class: openvpn::firewall
#
# Manages openvpn firewalling using custom Firewall wrapper
# By default it opens openvpn's default port(s) to anybody
# It's automatically included if $firewall=yes
#
# Usage:
# Automatically included if $firewall=yes 
#
class openvpn::firewall {

    include openvpn::params

    firewall { "openvpn_${openvpn::params::protocol}_${openvpn::params::port}":
        source      => "${openvpn::params::firewall_source_real}",
        destination => "${openvpn::params::firewall_destination_real}",
        protocol    => "${openvpn::params::protocol}",
        port        => "${openvpn::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "${openvpn::params::firewall_enable}",
    }

}
