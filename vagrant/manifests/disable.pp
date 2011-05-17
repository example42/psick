# Class: vagrant::disable
#
# Stops vagrant service and disables it at boot time
# Removes the monitor checks, but not the other extended elements (backup, firewall)
# Use vagrant::absent to remove everything
#
# Usage:
# include vagrant::disable
#
class vagrant::disable inherits vagrant {

    require vagrant::params

    Service["vagrant"] {
        ensure => "stopped" ,
        enable => "false",
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include vagrant::monitor::absent }
    # if $backup == "yes" { include vagrant::backup::absent }
    # if $firewall == "yes" { include vagrant::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include vagrant::debug }

}
