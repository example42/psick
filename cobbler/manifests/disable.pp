# Class: cobbler::disable
#
# Stops cobbler service and disables it at boot time
# Removes the monitor checks, but not the other extended elements (backup, firewall)
# Use cobbler::absent to remove everything
#
# Usage:
# include cobbler::disable
#
class cobbler::disable inherits cobbler {

    require cobbler::params

    Service["cobbler"] {
        ensure => "stopped" ,
        enable => "false",
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include cobbler::monitor::absent }
    # if $backup == "yes" { include cobbler::backup::absent }
    # if $firewall == "yes" { include cobbler::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include cobbler::debug }

}
