# Class: cobbler::firewall::absent
#
# Remove cobbler firewall elements
#
class cobbler::firewall::absent {

    include cobbler::params

    firewall { "cobbler_${cobbler::params::protocol}_${cobbler::params::port}":
        source      => "${cobbler::params::firewall_source_real}",
        destination => "${cobbler::params::firewall_destination_real}",
        protocol    => "${cobbler::params::protocol}",
        port        => "${cobbler::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "false",
    }

}
