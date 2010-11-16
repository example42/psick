# Class: varnish::firewall::absent
#
# Remove varnish firewall elements
#
class varnish::firewall::absent {

    include varnish::params

    firewall { "varnish_${varnish::params::protocol}_${varnish::params::port}":
        source      => "${varnish::params::firewall_source_real}",
        destination => "${varnish::params::firewall_destination_real}",
        protocol    => "${varnish::params::protocol}",
        port        => "${varnish::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "false",
    }

}
