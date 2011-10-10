# Class: powerdns::firewall
#
# Manages powerdns firewalling using custom Firewall wrapper
# By default it opens powerdns's default port(s) to anybody
# It's automatically included if $firewall=yes
#
# Usage:
# Automatically included if $firewall=yes 
#
class powerdns::firewall {

    include powerdns::params

    firewall { "powerdns_${powerdns::params::protocol}_${powerdns::params::port}":
        source      => "${powerdns::params::firewall_source_real}",
        destination => "${powerdns::params::firewall_destination_real}",
        protocol    => "${powerdns::params::protocol}",
        port        => "${powerdns::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "${powerdns::params::firewall_enable}",
    }

}
