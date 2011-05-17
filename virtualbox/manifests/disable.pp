# Class: virtualbox::disable
#
# Stops virtualbox service and disables it at boot time
# Removes the monitor checks, but not the other extended elements (backup, firewall)
# Use virtualbox::absent to remove everything
#
# Usage:
# include virtualbox::disable
#
class virtualbox::disable inherits virtualbox {

    require virtualbox::params

    Service["virtualbox"] {
        ensure => "stopped" ,
        enable => "false",
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include virtualbox::monitor::absent }
    # if $backup == "yes" { include virtualbox::backup::absent }
    # if $firewall == "yes" { include virtualbox::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include virtualbox::debug }

}
