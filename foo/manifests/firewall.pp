# Class: foo::firewall
#
# Manages foo firewalling using custom Firewall wrapper
# By default it opens foo's default port(s) to anybody
# It's automatically included if $firewall=yes
#
# Usage:
# Automatically included if $firewall=yes 
#
class foo::firewall {

    include foo::params

    firewall { "foo_${foo::params::protocol}_${foo::params::port}":
        source      => "${foo::params::firewall_source_real}",
        destination => "${foo::params::firewall_destination_real}",
        protocol    => "${foo::params::protocol}",
        port        => "${foo::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "${foo::params::firewall_enable}",
    }

}
