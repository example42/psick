# Class: portmap::firewall::absent
#
# Remove portmap firewall elements
#
class portmap::firewall::absent {

    include portmap::params

    firewall { "portmap_${portmap::params::protocol}_${portmap::params::port}":
        source      => "${portmap::params::firewall_source_real}",
        destination => "${portmap::params::firewall_destination_real}",
        protocol    => "${portmap::params::protocol}",
        port        => "${portmap::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "false",
    }

}
