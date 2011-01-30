# Class: lighttpd::firewall
#
# Manages lighttpd firewalling using custom Firewall wrapper
# By default it opens lighttpd's default port(s) to anybody
# It's automatically included if $firewall=yes
#
# Usage:
# Automatically included if $firewall=yes 
#
class lighttpd::firewall {

    include lighttpd::params

    firewall { "lighttpd_${lighttpd::params::protocol}_${lighttpd::params::port}":
        source      => "${lighttpd::params::firewall_source_real}",
        destination => "${lighttpd::params::firewall_destination_real}",
        protocol    => "${lighttpd::params::protocol}",
        port        => "${lighttpd::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "${lighttpd::params::firewall_enable}",
    }

}
