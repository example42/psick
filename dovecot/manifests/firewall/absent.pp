# Class: dovecot::firewall::absent
#
# Remove dovecot firewall elements
#
class dovecot::firewall::absent {

    include dovecot::params

    firewall { "dovecot_${dovecot::params::protocol}_${dovecot::params::port}":
        source      => "${dovecot::params::firewall_source_real}",
        destination => "${dovecot::params::firewall_destination_real}",
        protocol    => "${dovecot::params::protocol}",
        port        => "${dovecot::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "false",
    }

}
