# Class: postgresql::monitor
#
# Monitors postgresql process/ports/service using Example42 monitor meta module (to be adapted to custom monitor solutions)
# It's automatically included and used if $monitor=yes and is defined at least one monitoring software in $monitor_tool
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $postgresql_monitor_port (true|false) : Set if you want to monitor postgresql's port(s). If any. Default: As defined in $monitor_port
# $postgresql_monitor_process (true|false) : Set if you want to monitor postgresql's process. If any. Default: As defined in $monitor_process
# $postgresql_monitor_target : Define how to reach (Ip, fqdn...) the host to monitor postgresql from an external server. Default: As defined in $monitor_target
# 
# You can therefore set site wide variables that can be overriden by the above module specific ones:
# $monitor_port (true|false) : Set if you want to enable port monitoring site-wide.
# $monitor_process (true|false) : Set if you want to enable process monitoring site-wide.
# $monitor_target : Set the ip/hostname you want to use on an external monitoring server to monitor this host
# For the defaults of the above variables check postgresql::params
#
# Usage:
# Automatically included if $monitor=yes
# Use the variable $monitor_tool (can be an array) to define the monitoring software you want to use.
#
class postgresql::monitor {

    include postgresql::params

    # Port monitoring
    monitor::port { "postgresql_${postgresql::params::protocol}_${postgresql::params::port}": 
        protocol => "${postgresql::params::protocol}",
        port     => "${postgresql::params::port}",
        target   => "${postgresql::params::monitor_target_real}",
        enable   => "${postgresql::params::monitor_port_enable}",
        tool     => "${monitor_tool}",
    }
    
    # Process monitoring 
    monitor::process { "postgresql_process":
        process  => "${postgresql::params::processname}",
        service  => "${postgresql::params::servicename}",
        pidfile  => "${postgresql::params::pidfile}",
        enable   => "${postgresql::params::monitor_process_enable}",
        tool     => "${monitor_tool}",
    }

}
