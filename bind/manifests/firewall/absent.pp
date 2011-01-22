# Class: bind::firewall::absent
#
# Remove bind firewall elements
#
class bind::firewall::absent {

    include bind::params

    firewall { "bind_${bind::params::protocol}_${bind::params::port}":
        source      => "${bind::params::firewall_source_real}",
        destination => "${bind::params::firewall_destination_real}",
        protocol    => "${bind::params::protocol}",
        port        => "${bind::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "false",
    }

}
