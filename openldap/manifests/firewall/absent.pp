# Class: openldap::firewall::absent
#
# Remove openldap firewall elements
#
class openldap::firewall::absent {

    include openldap::params

    firewall { "openldap_${openldap::params::protocol}_${openldap::params::port}":
        source      => "${openldap::params::firewall_source_real}",
        destination => "${openldap::params::firewall_destination_real}",
        protocol    => "${openldap::params::protocol}",
        port        => "${openldap::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "false",
    }

}
