# Class: vmware::firewall
#
# Manages vmware firewalling using custom Firewall wrapper
# By default it opens vmware's default port(s) to anybody
# It's automatically included if $firewall=yes
#
# Usage:
# Automatically included if $firewall=yes 
#
class vmware::firewall {

    include vmware::params

    firewall { "vmware_${vmware::params::protocol}_${vmware::params::port}":
        source      => "${vmware::params::firewall_source_real}",
        destination => "${vmware::params::firewall_destination_real}",
        protocol    => "${vmware::params::protocol}",
        port        => "${vmware::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "${vmware::params::firewall_enable}",
    }

}
