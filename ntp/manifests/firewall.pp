# Class: ntp::firewall
#
# Manages ntp firewalling using custom Firewall wrapper
# By default it opens ntp's default port(s) to anybody
# It's automatically included if $firewall=yes
#
# Usage:
# Automatically included if $firewall=yes 
#
class ntp::firewall {

    include ntp::params

    firewall { "ntp_${ntp::params::protocol}_${ntp::params::port}":
        source      => "${ntp::params::firewall_source_real}",
        destination => "${ntp::params::firewall_destination_real}",
        protocol    => "${ntp::params::protocol}",
        port        => "${ntp::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "${ntp::params::firewall_enable}",
    }

}
