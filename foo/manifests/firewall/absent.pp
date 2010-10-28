# Class: foo::firewall::absent
#
# Remove foo firewall elements
#
class foo::firewall::absent {

    include foo::params

    firewall { "foo_${foo::params::protocol}_${foo::params::port}":
        source      => "${foo::params::firewall_source_real}",
        destination => "${foo::params::firewall_destination_real}",
        protocol    => "${foo::params::protocol}",
        port        => "${foo::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "false",
    }

}
