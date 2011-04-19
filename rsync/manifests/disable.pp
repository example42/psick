# Class: rsync::disable
#
# Stops rsync service and disables it at boot time
# Removes the monitor checks, but not the other extended elements (backup, firewall)
# Use rsync::absent to remove everything
#
# Usage:
# include rsync::disable
#
class rsync::disable inherits rsync {

    require rsync::params

    Service["rsync"] {
        ensure => "stopped" ,
        enable => "false",
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include rsync::monitor::absent }
    # if $backup == "yes" { include rsync::backup::absent }
    # if $firewall == "yes" { include rsync::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include rsync::debug }

}
