# Class: snmpd::firewall
#
# Manages snmpd firewalling using custom Firewall wrapper
# By default it opens snmpd's default port(s) to anybody
# It's automatically included if $firewall=yes
#
# Usage:
# Automatically included if $firewall=yes 
#
class snmpd::firewall {

    include snmpd::params

    firewall { "snmpd_${snmpd::params::protocol}_${snmpd::params::port}":
        source      => "${snmpd::params::firewall_source_real}",
        destination => "${snmpd::params::firewall_destination_real}",
        protocol    => "${snmpd::params::protocol}",
        port        => "${snmpd::params::port}",
        action      => "allow",
        direction   => "input",
    }

}

