# Class: postfix::firewall
#
# Manages postfix firewalling using custom Firewall wrapper
# By default it opens postfix's default port(s) to anybody
# It's automatically included if $firewall=yes
#
# Usage:
# Automatically included if $firewall=yes 
#
class postfix::firewall {

    include postfix::params

    firewall { "postfix_${postfix::params::protocol}_${postfix::params::port}":
        source      => "${postfix::params::firewall_source_real}",
        destination => "${postfix::params::firewall_destination_real}",
        protocol    => "${postfix::params::protocol}",
        port        => "${postfix::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "${postfix::params::firewall_enable}",
    }

}
