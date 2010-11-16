# Class: varnish::disable
#
# Stops varnish service and disables it at boot time
# Removes the monitor checks, but not the other extended elements (backup, firewall)
# Use varnish::absent to remove everything
#
# Usage:
# include varnish::disable
#
class varnish::disable inherits varnish {

    require varnish::params

    Service["varnish"] {
        ensure => "stopped" ,
        enable => "false",
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include varnish::monitor::absent }
    # if $backup == "yes" { include varnish::backup::absent }
    # if $firewall == "yes" { include varnish::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include varnish::debug }

}
