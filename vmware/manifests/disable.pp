# Class: vmware::disable
#
# Stops vmware service and disables it at boot time
# Removes the monitor checks, but not the other extended elements (backup, firewall)
# Use vmware::absent to remove everything
#
# Usage:
# include vmware::disable
#
class vmware::disable inherits vmware {

    require vmware::params

    Service["vmware"] {
        ensure => "stopped" ,
        enable => "false",
    }

    # Remove relevant monitor, backup, firewall entries
#    if $monitor == "yes" { include vmware::monitor::absent }
    # if $backup == "yes" { include vmware::backup::absent }
    # if $firewall == "yes" { include vmware::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include vmware::debug }

}
