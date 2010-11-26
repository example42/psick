# Class: munin::firewall::absent
#
# Remove munin firewall elements
#
class munin::firewall::absent {

    include munin::params

    firewall { "munin_${munin::params::protocol}_${munin::params::port}":
        source      => "${munin::params::firewall_source_real}",
        destination => "${munin::params::firewall_destination_real}",
        protocol    => "${munin::params::protocol}",
        port        => "${munin::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "false",
    }

}
