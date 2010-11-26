# Class: dovecot::disable
#
# Stops dovecot service and disables it at boot time
# Removes the monitor checks, but not the other extended elements (backup, firewall)
# Use dovecot::absent to remove everything
#
# Usage:
# include dovecot::disable
#
class dovecot::disable inherits dovecot {

    require dovecot::params

    Service["dovecot"] {
        ensure => "stopped" ,
        enable => "false",
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include dovecot::monitor::absent }
    # if $backup == "yes" { include dovecot::backup::absent }
    # if $firewall == "yes" { include dovecot::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include dovecot::debug }

}
