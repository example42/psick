# Class: exim::firewall::absent
#
# Remove exim firewall elements
#
class exim::firewall::absent {

    include exim::params

    firewall { "exim_${exim::params::protocol}_${exim::params::port}":
        source      => "${exim::params::firewall_source_real}",
        destination => "${exim::params::firewall_destination_real}",
        protocol    => "${exim::params::protocol}",
        port        => "${exim::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "false",
    }

}
