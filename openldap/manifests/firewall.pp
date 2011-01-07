# Class: openldap::firewall
#
# Manages openldap firewalling using custom Firewall wrapper
# By default it opens openldap's default port(s) to anybody
# It's automatically included if $firewall=yes
#
# Usage:
# Automatically included if $firewall=yes 
#
class openldap::firewall {

    include openldap::params

    firewall { "openldap_${openldap::params::protocol}_${openldap::params::port}":
        source      => "${openldap::params::firewall_source_real}",
        destination => "${openldap::params::firewall_destination_real}",
        protocol    => "${openldap::params::protocol}",
        port        => "${openldap::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "${openldap::params::firewall_enable}",
    }

}
