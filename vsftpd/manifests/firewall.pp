# Class: vsftpd::firewall
#
# Manages vsftpd firewalling using custom Firewall wrapper
# By default it opens vsftpd's default port(s) to anybody
# It's automatically included if $firewall=yes
#
# Usage:
# Automatically included if $firewall=yes 
#
class vsftpd::firewall {

    include vsftpd::params

    firewall { "vsftpd_${vsftpd::params::protocol}_${vsftpd::params::port}":
        source      => "${vsftpd::params::firewall_source_real}",
        destination => "${vsftpd::params::firewall_destination_real}",
        protocol    => "${vsftpd::params::protocol}",
        port        => "${vsftpd::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "${vsftpd::params::firewall_enable}",
    }

}
