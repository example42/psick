# Class: tomcat::disable
#
# Stops tomcat service and disables it at boot time
# Removes the monitor checks, but not the other extended elements (backup, firewall)
# Use tomcat::absent to remove everything
#
# Usage:
# include tomcat::disable
#
class tomcat::disable inherits tomcat {

    require tomcat::params

    Service["tomcat"] {
        ensure => "stopped" ,
        enable => "false",
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include tomcat::monitor::absent }
    # if $backup == "yes" { include tomcat::backup::absent }
    # if $firewall == "yes" { include tomcat::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include tomcat::debug }

}
