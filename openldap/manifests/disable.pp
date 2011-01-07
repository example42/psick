# Class: openldap::disable
#
# Stops openldap service and disables it at boot time
# Removes the monitor checks, but not the other extended elements (backup, firewall)
# Use openldap::absent to remove everything
#
# Usage:
# include openldap::disable
#
class openldap::disable inherits openldap {

    require openldap::params

    Service["openldap"] {
        ensure => "stopped" ,
        enable => "false",
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include openldap::monitor::absent }
    # if $backup == "yes" { include openldap::backup::absent }
    # if $firewall == "yes" { include openldap::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include openldap::debug }

}
