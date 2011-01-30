# Class: apache::firewall
#
# Manages apache firewalling using custom Firewall wrapper
# By default it opens apache's default port(s) to anybody
# It's automatically included if $firewall=yes
#
# Usage:
# Automatically included if $firewall=yes 
#
class apache::firewall {

    include apache::params

    firewall { "apache_${apache::params::protocol}_${apache::params::port}":
        source      => "${apache::params::firewall_source_real}",
        destination => "${apache::params::firewall_destination_real}",
        protocol    => "${apache::params::protocol}",
        port        => "${apache::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "${apache::params::firewall_enable}",
    }

}

