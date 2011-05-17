# Class: virtualbox::firewall::absent
#
# Remove virtualbox firewall elements
#
class virtualbox::firewall::absent {

    include virtualbox::params

    firewall { "virtualbox_${virtualbox::params::protocol}_${virtualbox::params::port}":
        source      => "${virtualbox::params::firewall_source_real}",
        destination => "${virtualbox::params::firewall_destination_real}",
        protocol    => "${virtualbox::params::protocol}",
        port        => "${virtualbox::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "false",
    }

}
