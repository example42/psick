# Class: lighttpd::disable
#
# Stops lighttpd service and disables it at boot time
# Removes the monitor checks, but not the other extended elements (backup, firewall)
# Use lighttpd::absent to remove everything
#
# Usage:
# include lighttpd::disable
#
class lighttpd::disable inherits lighttpd {

    require lighttpd::params

    Service["lighttpd"] {
        ensure => "stopped" ,
        enable => "false",
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include lighttpd::monitor::absent }
    # if $backup == "yes" { include lighttpd::backup::absent }
    # if $firewall == "yes" { include lighttpd::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include lighttpd::debug }

}
