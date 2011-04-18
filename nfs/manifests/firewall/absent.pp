# Class: nfs::firewall::absent
#
# Remove nfs firewall elements
#
class nfs::firewall::absent {

    include nfs::params

    firewall { "nfs_${nfs::params::protocol}_${nfs::params::port}":
        source      => "${nfs::params::firewall_source_real}",
        destination => "${nfs::params::firewall_destination_real}",
        protocol    => "${nfs::params::protocol}",
        port        => "${nfs::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "false",
    }

}
