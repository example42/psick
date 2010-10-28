# Class: collectd::firewall::absent
#
# Remove collectd firewall elements
#
class collectd::firewall::absent {

    include collectd::params

    firewall { "collectd_${collectd::params::protocol}_${collectd::params::port}":
        source      => "${collectd::params::firewall_source_real}",
        destination => "${collectd::params::firewall_destination_real}",
        protocol    => "${collectd::params::protocol}",
        port        => "${collectd::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "false",
    }

}
