# Class: collectd::disable
#
# Stops collectd service and disables it at boot time
# Removes the monitor checks, but not the other extended elements (backup, firewall)
# Use collectd::absent to remove everything
#
# Usage:
# include collectd::disable
#
class collectd::disable inherits collectd {

    require collectd::params

    Service["collectd"] {
        ensure => "stopped" ,
        enable => "false",
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include collectd::monitor::absent }
    # if $backup == "yes" { include collectd::backup::absent }
    # if $firewall == "yes" { include collectd::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include collectd::debug }

}
