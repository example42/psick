# Class: munin::firewall
#
# Manages munin firewalling using custom Firewall wrapper
# By default it opens munin's default port(s) to anybody
# It's automatically included if $firewall=yes
#
# Usage:
# Automatically included if $firewall=yes 
#
class munin::firewall {

    include munin::params

    firewall { "munin_${munin::params::protocol}_${munin::params::port}":
        source      => "${munin::params::firewall_source_real}",
        destination => "${munin::params::firewall_destination_real}",
        protocol    => "${munin::params::protocol}",
        port        => "${munin::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "${munin::params::firewall_enable}",
    }

}
