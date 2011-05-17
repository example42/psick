# Class: vagrant::firewall::absent
#
# Remove vagrant firewall elements
#
class vagrant::firewall::absent {

    include vagrant::params

    firewall { "vagrant_${vagrant::params::protocol}_${vagrant::params::port}":
        source      => "${vagrant::params::firewall_source_real}",
        destination => "${vagrant::params::firewall_destination_real}",
        protocol    => "${vagrant::params::protocol}",
        port        => "${vagrant::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "false",
    }

}
