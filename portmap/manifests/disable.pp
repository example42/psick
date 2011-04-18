# Class: portmap::disable
#
# Stops portmap service and disables it at boot time
# Removes the monitor checks, but not the other extended elements (backup, firewall)
# Use portmap::absent to remove everything
#
# Usage:
# include portmap::disable
#
class portmap::disable inherits portmap {

    require portmap::params

    Service["portmap"] {
        ensure => "stopped" ,
        enable => "false",
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include portmap::monitor::absent }
    # if $backup == "yes" { include portmap::backup::absent }
    # if $firewall == "yes" { include portmap::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include portmap::debug }

}
