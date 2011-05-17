# Class: vagrant::firewall
#
# Manages vagrant firewalling using custom Firewall wrapper
# By default it opens vagrant's default port(s) to anybody
# It's automatically included if $firewall=yes
#
# Usage:
# Automatically included if $firewall=yes 
#
class vagrant::firewall {

    include vagrant::params

    firewall { "vagrant_${vagrant::params::protocol}_${vagrant::params::port}":
        source      => "${vagrant::params::firewall_source_real}",
        destination => "${vagrant::params::firewall_destination_real}",
        protocol    => "${vagrant::params::protocol}",
        port        => "${vagrant::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "${vagrant::params::firewall_enable}",
    }

}
