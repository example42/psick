# Class: rsyslog::firewall::absent
#
# Remove rsyslog firewall elements
#
class rsyslog::firewall::absent {

    include rsyslog::params

    firewall { "rsyslog_${rsyslog::params::protocol}_${rsyslog::params::port}":
        source      => "${rsyslog::params::firewall_source_real}",
        destination => "${rsyslog::params::firewall_destination_real}",
        protocol    => "${rsyslog::params::protocol}",
        port        => "${rsyslog::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "false",
    }

}
