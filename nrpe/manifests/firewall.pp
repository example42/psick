# Class: nrpe::firewall
#
# Manages nrpe firewalling using custom Firewall wrapper
# By default it opens nrpe's default port(s) to anybody
# It's automatically included if $firewall=yes
#
# Usage:
# Automatically included if $firewall=yes 
#
class nrpe::firewall {

    include nrpe::params

    firewall { "nrpe_${nrpe::params::protocol}_${nrpe::params::port}":
        source      => "${nrpe::params::firewall_source_real}",
        destination => "${nrpe::params::firewall_destination_real}",
        protocol    => "${nrpe::params::protocol}",
        port        => "${nrpe::params::port}",
        action      => "allow",
        direction   => "input",
    }

}
