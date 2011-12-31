# Class: autofs::monitor
#
# Usage:
# Automatically included if $monitor=yes
# Use the variable $monitor_tool (can be an array) to define the monitoring software you want to use.
# To customize specific and more granular behaviours use the above variables and eventually your custom modulename::monitor::$my_project class
#
class autofs::monitor {

    include autofs::params

    # Process monitoring 
    monitor::process { "autofs_process":
        process  => "${autofs::params::processname}",
        service  => "${autofs::params::servicename}",
        pidfile  => "${autofs::params::pidfile}",
        enable   => "${autofs::params::monitor_process_enable}",
        tool     => "${monitor_tool}",
    }

    # Include project specific class if $my_project is set
    if $my_project { include "autofs::${my_project}::monitor" }

}

