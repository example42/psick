# Class: ntp::firewall::absent
#
# Remove ntp firewall elements
#
class ntp::firewall::absent {

    include ntp::params

    firewall { "ntp_${ntp::params::protocol}_${ntp::params::port}":
        source      => "${ntp::params::firewall_source_real}",
        destination => "${ntp::params::firewall_destination_real}",
        protocol    => "${ntp::params::protocol}",
        port        => "${ntp::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "false",
    }

}
