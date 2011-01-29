# Class: lighttpd::firewall::absent
#
# Remove lighttpd firewall elements
#
class lighttpd::firewall::absent {

    include lighttpd::params

    firewall { "lighttpd_${lighttpd::params::protocol}_${lighttpd::params::port}":
        source      => "${lighttpd::params::firewall_source_real}",
        destination => "${lighttpd::params::firewall_destination_real}",
        protocol    => "${lighttpd::params::protocol}",
        port        => "${lighttpd::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "false",
    }

}
