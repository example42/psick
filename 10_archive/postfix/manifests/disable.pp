# Class: postfix::disable
#
# Stops postfix service and disables it at boot time
# Removes the monitor checks, but not the other extended elements (backup, firewall)
# Use postfix::absent to remove everything
#
# Usage:
# include postfix::disable
#
class postfix::disable inherits postfix {

    require postfix::params

    Service["postfix"] {
        ensure => "stopped" ,
        enable => "false",
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include postfix::monitor::absent }
    # if $backup == "yes" { include postfix::backup::absent }
    # if $firewall == "yes" { include postfix::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include postfix::debug }

}
