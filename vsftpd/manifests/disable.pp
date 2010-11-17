# Class: vsftpd::disable
#
# Stops vsftpd service and disables it at boot time
# Removes the monitor checks, but not the other extended elements (backup, firewall)
# Use vsftpd::absent to remove everything
#
# Usage:
# include vsftpd::disable
#
class vsftpd::disable inherits vsftpd {

    require vsftpd::params

    Service["vsftpd"] {
        ensure => "stopped" ,
        enable => "false",
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include vsftpd::monitor::absent }
    # if $backup == "yes" { include vsftpd::backup::absent }
    # if $firewall == "yes" { include vsftpd::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include vsftpd::debug }

}
