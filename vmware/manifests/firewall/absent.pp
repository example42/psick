# Class: vmware::firewall::absent
#
# Remove vmware firewall elements
#
class vmware::firewall::absent {

    include vmware::params

    firewall { "vmware_${vmware::params::protocol}_${vmware::params::port}":
        source      => "${vmware::params::firewall_source_real}",
        destination => "${vmware::params::firewall_destination_real}",
        protocol    => "${vmware::params::protocol}",
        port        => "${vmware::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "false",
    }

}
