# Class: samba::firewall
#
# Manages samba firewalling using custom Firewall wrapper
# By default it opens samba's default port(s) to anybody
# It's automatically included if $firewall=yes
#
# Usage:
# Automatically included if $firewall=yes 
#
class samba::firewall {

    include samba::params

    firewall { "samba_${samba::params::protocol}_${samba::params::port}":
        source      => "${samba::params::firewall_source_real}",
        destination => "${samba::params::firewall_destination_real}",
        protocol    => "${samba::params::protocol}",
        port        => "${samba::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "${samba::params::firewall_enable}",
    }

}
