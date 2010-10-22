# Class: nagios::firewall
#
# Manages nagios firewalling using custom Firewall wrapper
# By default it opens nagios's default port(s) to anybody
# It's automatically included if $firewall=yes
#
# Usage:
# Automatically included if $firewall=yes 
#
class nagios::firewall {

    include nagios::params

    firewall { "nagios_${nagios::params::protocol}_${nagios::params::port}":
        source      => "${nagios::params::firewall_source_real}",
        destination => "${nagios::params::firewall_destination_real}",
        protocol    => "${nagios::params::protocol}",
        port        => "${nagios::params::port}",
        action      => "allow",
        direction   => "input",
    }

}
