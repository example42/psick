# Class: rsync::firewall::absent
#
# Remove rsync firewall elements
#
class rsync::firewall::absent {

    include rsync::params

    firewall { "rsync_${rsync::params::protocol}_${rsync::params::port}":
        source      => "${rsync::params::firewall_source_real}",
        destination => "${rsync::params::firewall_destination_real}",
        protocol    => "${rsync::params::protocol}",
        port        => "${rsync::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "false",
    }

}
