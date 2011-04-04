# Class: openvpn::firewall::absent
#
# Remove openvpn firewall elements
#
class openvpn::firewall::absent {

    include openvpn::params

    firewall { "openvpn_${openvpn::params::protocol}_${openvpn::params::port}":
        source      => "${openvpn::params::firewall_source_real}",
        destination => "${openvpn::params::firewall_destination_real}",
        protocol    => "${openvpn::params::protocol}",
        port        => "${openvpn::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "false",
    }

}
