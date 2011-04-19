# Class: cobbler::firewall
#
# Manages cobbler firewalling using custom Firewall wrapper
# By default it opens cobbler's default port(s) to anybody
# It's automatically included if $firewall=yes
#
# Usage:
# Automatically included if $firewall=yes 
#
class cobbler::firewall {

    include cobbler::params

    firewall { "cobbler_${cobbler::params::protocol}_${cobbler::params::port}":
        source      => "${cobbler::params::firewall_source_real}",
        destination => "${cobbler::params::firewall_destination_real}",
        protocol    => "${cobbler::params::protocol}",
        port        => "${cobbler::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "${cobbler::params::firewall_enable}",
    }

}
