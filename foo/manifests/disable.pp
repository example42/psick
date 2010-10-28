# Class: foo::disable
#
# Stops foo service and disables it at boot time
# Removes the monitor checks, but not the other extended elements (backup, firewall)
# Use foo::absent to remove everything
#
# Usage:
# include foo::disable
#
class foo::disable inherits foo {

    require foo::params

    Service["foo"] {
        ensure => "stopped" ,
        enable => "false",
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include foo::monitor::absent }
    # if $backup == "yes" { include foo::backup::absent }
    # if $firewall == "yes" { include foo::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include foo::debug }

}
