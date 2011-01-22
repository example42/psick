# Class: bind::firewall
#
# Manages bind firewalling using custom Firewall wrapper
# By default it opens bind's default port(s) to anybody
# It's automatically included if $firewall=yes
#
# Usage:
# Automatically included if $firewall=yes 
#
class bind::firewall {

    include bind::params

    firewall { "bind_${bind::params::protocol}_${bind::params::port}":
        source      => "${bind::params::firewall_source_real}",
        destination => "${bind::params::firewall_destination_real}",
        protocol    => "${bind::params::protocol}",
        port        => "${bind::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "${bind::params::firewall_enable}",
    }

}
