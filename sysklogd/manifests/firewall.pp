# Class: sysklogd::firewall
#
# Manages sysklogd firewalling using custom Firewall wrapper
# By default it opens sysklogd's default port(s) to anybody
# It's automatically included if $firewall=yes
#
# Usage:
# Automatically included if $firewall=yes 
#
class sysklogd::firewall {

    include sysklogd::params

    firewall { "sysklogd_${sysklogd::params::protocol}_${sysklogd::params::port}":
        source      => "${sysklogd::params::firewall_source_real}",
        destination => "${sysklogd::params::firewall_destination_real}",
        protocol    => "${sysklogd::params::protocol}",
        port        => "${sysklogd::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "${sysklogd::params::firewall_enable}",
    }

}
