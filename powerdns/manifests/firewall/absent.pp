# Class: powerdns::firewall::absent
#
# Remove powerdns firewall elements
#
class powerdns::firewall::absent {

    include powerdns::params

    firewall { "powerdns_${powerdns::params::protocol}_${powerdns::params::port}":
        source      => "${powerdns::params::firewall_source_real}",
        destination => "${powerdns::params::firewall_destination_real}",
        protocol    => "${powerdns::params::protocol}",
        port        => "${powerdns::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "false",
    }

}
