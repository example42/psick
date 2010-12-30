# Class: samba::disable
#
# Stops samba service and disables it at boot time
# Removes the monitor checks, but not the other extended elements (backup, firewall)
# Use samba::absent to remove everything
#
# Usage:
# include samba::disable
#
class samba::disable inherits samba {

    require samba::params

    Service["samba"] {
        ensure => "stopped" ,
        enable => "false",
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include samba::monitor::absent }
    # if $backup == "yes" { include samba::backup::absent }
    # if $firewall == "yes" { include samba::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include samba::debug }

}
