# Class: rsyslog::disable
#
# Stops rsyslog service and disables it at boot time
# Removes the monitor checks, but not the other extended elements (backup, firewall)
# Use rsyslog::absent to remove everything
#
# Usage:
# include rsyslog::disable
#
class rsyslog::disable inherits rsyslog {

    require rsyslog::params

    Service["rsyslog"] {
        ensure => "stopped" ,
        enable => "false",
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include rsyslog::monitor::absent }
    # if $backup == "yes" { include rsyslog::backup::absent }
    # if $firewall == "yes" { include rsyslog::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include rsyslog::debug }

}
