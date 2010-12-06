# Class: sysklogd::firewall::absent
#
# Remove sysklogd firewall elements
#
class sysklogd::firewall::absent {

    include sysklogd::params

    firewall { "sysklogd_${sysklogd::params::protocol}_${sysklogd::params::port}":
        source      => "${sysklogd::params::firewall_source_real}",
        destination => "${sysklogd::params::firewall_destination_real}",
        protocol    => "${sysklogd::params::protocol}",
        port        => "${sysklogd::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "false",
    }

}
