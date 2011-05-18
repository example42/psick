# Class: dhcpd::firewall::absent
#
# Remove dhcpd firewall elements
#
class dhcpd::firewall::absent {

    include dhcpd::params

    firewall { "dhcpd_${dhcpd::params::protocol}_${dhcpd::params::port}":
        source      => "${dhcpd::params::firewall_source_real}",
        destination => "${dhcpd::params::firewall_destination_real}",
        protocol    => "${dhcpd::params::protocol}",
        port        => "${dhcpd::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "false",
    }

}
