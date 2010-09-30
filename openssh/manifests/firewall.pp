# Class: openssh::firewall
#
# Manages openssh firewalling using custom Firewall wrapper
# By default it opens openssh's default port(s) to anybody
# It's automatically included if $firewall=yes
#
# Usage:
# Automatically included if $firewall=yes 
#
class openssh::firewall {

    include openssh::params

    firewall { "openssh_${openssh::params::protocol}_${openssh::params::port}":
        source      => "${openssh::params::firewall_source_real}",
        destination => "${openssh::params::firewall_destination_real}",
        protocol    => "${openssh::params::protocol}",
        port        => "${openssh::params::port}",
        action      => "allow",
        direction   => "input",
    }

}

