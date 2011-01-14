# Class: bind::disable
#
# Stops bind service and disables it at boot time
# Removes the monitor checks, but not the other extended elements (backup, firewall)
# Use bind::absent to remove everything
#
# Usage:
# include bind::disable
#
class bind::disable inherits bind {

    require bind::params

    Service["bind"] {
        ensure => "stopped" ,
        enable => "false",
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include bind::monitor::absent }
    # if $backup == "yes" { include bind::backup::absent }
    # if $firewall == "yes" { include bind::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include bind::debug }

}
