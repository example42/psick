# Class: sysklogd::disable
#
# Stops sysklogd service and disables it at boot time
# Removes the monitor checks, but not the other extended elements (backup, firewall)
# Use sysklogd::absent to remove everything
#
# Usage:
# include sysklogd::disable
#
class sysklogd::disable inherits sysklogd {

    Service["sysklogd"] {
        ensure     => "stopped" ,
        enable     => "false",
    }

    # Remove relevant monitor, backup, firewall entries
    if $monitor == "yes" { include sysklogd::monitor::absent }
    # if $backup == "yes" { include sysklogd::backup::absent }
    # if $firewall == "yes" { include sysklogd::firewall::absent  }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include sysklogd::debug }

}
