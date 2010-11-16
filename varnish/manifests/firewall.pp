# Class: varnish::firewall
#
# Manages varnish firewalling using custom Firewall wrapper
# By default it opens varnish's default port(s) to anybody
# It's automatically included if $firewall=yes
#
# Usage:
# Automatically included if $firewall=yes 
#
class varnish::firewall {

    include varnish::params

    firewall { "varnish_${varnish::params::protocol}_${varnish::params::port}":
        source      => "${varnish::params::firewall_source_real}",
        destination => "${varnish::params::firewall_destination_real}",
        protocol    => "${varnish::params::protocol}",
        port        => "${varnish::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "${varnish::params::firewall_enable}",
    }

}
