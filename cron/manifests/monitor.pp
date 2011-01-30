# Class: cron::monitor
#
# Monitors cron process/ports/service using Example42 monitor meta module (to be adapted to custom monitor solutions)
# It's automatically included and used if $monitor=yes and is defined at least one monitoring software in $monitor_tool
# This class permits to abstract what you want to monitor from the actual tool and modules you'll use for monitoring
# and can be used to quickly deploy a new monitoring solution that instantly notifies what's working and what's needs
# to be fixed (call it Test Driven Puppet Deployment, if you like ;-)
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $cron_monitor_process (true|false) : Set if you want to monitor cron's process. If any. Default: As defined in $monitor_process
# 
# You can therefore set site wide variables that can be overriden by the above module specific ones:
# $monitor_process (true|false) : Set if you want to enable process monitoring site-wide.
# For the defaults of the above variables check cron::params
#
# Usage:
# Automatically included if $monitor=yes
# Use the variable $monitor_tool (can be an array) to define the monitoring software you want to use.
# To customize specific and more granular behaviours use the above variables and eventually your custom modulename::monitor::$my_project class
#
class cron::monitor {

    include cron::params

    # Process monitoring 
    monitor::process { "cron_process":
        process  => "${cron::params::processname}",
        service  => "${cron::params::servicename}",
        pidfile  => "${cron::params::pidfile}",
        enable   => "${cron::params::monitor_process_enable}",
        tool     => "${monitor_tool}",
    }

}
