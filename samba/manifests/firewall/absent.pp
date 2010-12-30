# Class: samba::firewall::absent
#
# Remove samba firewall elements
#
class samba::firewall::absent {

    include samba::params

    firewall { "samba_${samba::params::protocol}_${samba::params::port}":
        source      => "${samba::params::firewall_source_real}",
        destination => "${samba::params::firewall_destination_real}",
        protocol    => "${samba::params::protocol}",
        port        => "${samba::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "false",
    }

}
