# Class: postfix::firewall::absent
#
# Remove postfix firewall elements
#
class postfix::firewall::absent {

    include postfix::params

    firewall { "postfix_${postfix::params::protocol}_${postfix::params::port}":
        source      => "${postfix::params::firewall_source_real}",
        destination => "${postfix::params::firewall_destination_real}",
        protocol    => "${postfix::params::protocol}",
        port        => "${postfix::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "false",
    }

}
