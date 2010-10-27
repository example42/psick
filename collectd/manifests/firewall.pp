# Class: collectd::firewall
#
# Manages collectd firewalling using custom Firewall wrapper
# By default it opens collectd's default port(s) to anybody
# It's automatically included if $firewall=yes
#
# Usage:
# Automatically included if $firewall=yes 
#
class collectd::firewall {

    include collectd::params

    firewall { "collectd_${collectd::params::protocol}_${collectd::params::port}":
        source      => "${collectd::params::firewall_source_real}",
        destination => "${collectd::params::firewall_destination_real}",
        protocol    => "${collectd::params::protocol}",
        port        => "${collectd::params::port}",
        action      => "allow",
        direction   => "input",
    }

}
