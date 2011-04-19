# Class: rsync::firewall
#
# Manages rsync firewalling using custom Firewall wrapper
# By default it opens rsync's default port(s) to anybody
# It's automatically included if $firewall=yes
#
# Usage:
# Automatically included if $firewall=yes 
#
class rsync::firewall {

    include rsync::params

    firewall { "rsync_${rsync::params::protocol}_${rsync::params::port}":
        source      => "${rsync::params::firewall_source_real}",
        destination => "${rsync::params::firewall_destination_real}",
        protocol    => "${rsync::params::protocol}",
        port        => "${rsync::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "${rsync::params::firewall_enable}",
    }

}
