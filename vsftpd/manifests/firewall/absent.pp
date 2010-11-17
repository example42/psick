# Class: vsftpd::firewall::absent
#
# Remove vsftpd firewall elements
#
class vsftpd::firewall::absent {

    include vsftpd::params

    firewall { "vsftpd_${vsftpd::params::protocol}_${vsftpd::params::port}":
        source      => "${vsftpd::params::firewall_source_real}",
        destination => "${vsftpd::params::firewall_destination_real}",
        protocol    => "${vsftpd::params::protocol}",
        port        => "${vsftpd::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "false",
    }

}
