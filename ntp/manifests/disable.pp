# Class: ntp::disable
#
# Stops ntp service and disables it at boot time
# Removes the monitor checks, but not the other extended elements (backup, firewall)
# Use ntp::absent to remove everything
#
# Usage:
# include ntp::disable
#
class ntp::disable inherits ntp {

    require ntp::params

    Service["ntp"] {
        ensure => "stopped" ,
        enable => "false",
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include ntp::monitor::absent }
    # if $backup == "yes" { include ntp::backup::absent }
    # if $firewall == "yes" { include ntp::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include ntp::debug }

}
