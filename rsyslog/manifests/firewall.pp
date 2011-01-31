# Class: rsyslog::firewall
#
# Manages rsyslog firewalling using custom Firewall wrapper
# By default it opens rsyslog's default port(s) to anybody
# It's automatically included if $firewall=yes
#
# Usage:
# Automatically included if $firewall=yes 
#
class rsyslog::firewall {

    include rsyslog::params

    firewall { "rsyslog_${rsyslog::params::protocol}_${rsyslog::params::port}":
        source      => "${rsyslog::params::firewall_source_real}",
        destination => "${rsyslog::params::firewall_destination_real}",
        protocol    => "${rsyslog::params::protocol}",
        port        => "${rsyslog::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "${rsyslog::params::firewall_enable}",
    }

    firewall { "rsyslog_${rsyslog::params::protocol2}_${rsyslog::params::port2}":
        source      => "${rsyslog::params::firewall_source_real}",
        destination => "${rsyslog::params::firewall_destination_real}",
        protocol    => "${rsyslog::params::protocol2}",
        port        => "${rsyslog::params::port2}",
        action      => "allow",
        direction   => "input",
        enable      => "${rsyslog::params::firewall_enable}",
    }


}
