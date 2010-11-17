# Class: vsftpd::absent
#
# Removes vsftpd package and its relevant monitor, backup, firewall entries
#
# Usage:
# include vsftpd::absent
#
class vsftpd::absent {

    require vsftpd::params

    package { "vsftpd":
        name   => "${vsftpd::params::packagename}",
        ensure => absent,
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include vsftpd::monitor::absent }
    if $backup == "yes" { include vsftpd::backup::absent }
    if $firewall == "yes" { include vsftpd::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include vsftpd::debug }


}
