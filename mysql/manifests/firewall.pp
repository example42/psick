# Class: mysql::firewall
#
# Manages mysql firewalling using custom Firewall wrapper
# By default it opens mysql's default port(s) to anybody
# It's automatically included if $firewall=yes
#
# Usage:
# Automatically included if $firewall=yes 
#
class mysql::firewall {

    include mysql::params

    firewall { "mysql_${mysql::params::protocol}_${mysql::params::port}":
        source      => "${mysql::params::firewall_source_real}",
        destination => "${mysql::params::firewall_destination_real}",
        protocol    => "${mysql::params::protocol}",
        port        => "${mysql::params::port}",
        action      => "allow",
        direction   => "input",
    }

}
