# Class: nfs::disable
#
# Stops nfs service and disables it at boot time
# Removes the monitor checks, but not the other extended elements (backup, firewall)
# Use nfs::absent to remove everything
#
# Usage:
# include nfs::disable
#
class nfs::disable inherits nfs {

    require nfs::params

    Service["nfs"] {
        ensure => "stopped" ,
        enable => "false",
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include nfs::monitor::absent }
    # if $backup == "yes" { include nfs::backup::absent }
    # if $firewall == "yes" { include nfs::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include nfs::debug }

}
