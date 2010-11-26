# Class: munin::disable
#
# Stops munin service and disables it at boot time
# Removes the monitor checks, but not the other extended elements (backup, firewall)
# Use munin::absent to remove everything
#
# Usage:
# include munin::disable
#
class munin::disable inherits munin {

    require munin::params

    Service["munin-node"] {
        ensure => "stopped" ,
        enable => "false",
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include munin::monitor::absent }
    # if $backup == "yes" { include munin::backup::absent }
    # if $firewall == "yes" { include munin::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include munin::debug }

}
