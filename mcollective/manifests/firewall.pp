# Class: mcollective::firewall
#
# Manages mcollective firewalling using custom Firewall wrapper
# By default it opens mcollective's default port(s) to anybody
# It's automatically included if $firewall=yes
#
# Usage:
# Automatically included if $firewall=yes 
#
class mcollective::firewall {

    include mcollective::params

    firewall { "mcollective_${mcollective::params::protocol}_${mcollective::params::port}":
        source      => "${mcollective::params::firewall_source_real}",
        destination => "${mcollective::params::firewall_destination_real}",
        protocol    => "${mcollective::params::protocol}",
        port        => "${mcollective::params::port}",
        action      => "allow",
        direction   => "input",
    }

}
