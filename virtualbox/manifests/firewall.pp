# Class: virtualbox::firewall
#
# Manages virtualbox firewalling using custom Firewall wrapper
# By default it opens virtualbox's default port(s) to anybody
# It's automatically included if $firewall=yes
#
# Usage:
# Automatically included if $firewall=yes 
#
class virtualbox::firewall {

    include virtualbox::params

    firewall { "virtualbox_${virtualbox::params::protocol}_${virtualbox::params::port}":
        source      => "${virtualbox::params::firewall_source_real}",
        destination => "${virtualbox::params::firewall_destination_real}",
        protocol    => "${virtualbox::params::protocol}",
        port        => "${virtualbox::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "${virtualbox::params::firewall_enable}",
    }

}
