# Class: collectd::monitor
#
# Monitors collectd process/ports/service using Example42 monitor meta module (to be adapted to custom monitor solutions)
# It's automatically included ad used if $monitor=yes and is defined at least one monitoring software in $monitor_tool
# This class permits to abstract what you want to monitor from the actual tool and modules you'll use for monitoring
# and can be used to quickly deploy a new monitoring solution
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $collectd_monitor_port (true|false) : Set if you want to monitor collectd's port(s). If any. Default: As defined in $monitor_port
# $collectd_monitor_url (true|false) : Set if you want to monitor collectd's url(s). If any. Default: As defined in $monitor_url
# $collectd_monitor_process (true|false) : Set if you want to monitor collectd's process. If any. Default: As defined in $monitor_process
# $collectd_monitor_plugin (true|false) : Set if you want to monitor collectd using specific monitor tool's plugin  i   s. If any. Default: As defined in $monitor_plugin
# $collectd_monitor_target : Define how to reach (Ip, fqdn...) the host to monitor collectd from an external server. Default: As defined in $monitor_target
# $collectd_monitor_url : Define the baseurl (http://$fqdn/...) to use for eventual collectd URL checks. Default: As defined in $monitor_url
# 
# You can therefore set site wide variables that can be overriden by the above module specific ones:
# $monitor_port (true|false) : Set if you want to enable port monitoring site-wide.
# $monitor_url (true|false) : Set if you want to enable url checking site-wide.
# $monitor_process (true|false) : Set if you want to enable process monitoring site-wide.
# $monitor_plugin (true|false) : Set if you want to try to use specific plugins of your monitoring tools 
# $monitor_target : Set the ip/hostname you want to use on an external monitoring server to monitor this host
# $monitor_baseurl : Set baseurl to use for eventual URL checks of services provided by this host
# For the defaults of the above variables check collectd::params
#
# Usage:
# Automatically included if $monitor=yes
# Use the variable $monitor_tool (can be an array) to define the monitoring software you want to use.
# To customize specific and more granular behaviours use the above variables and eventually your custom modulename::monitor::$my_project class
#
class collectd::monitor {

    include collectd::params

    # Port monitoring
    monitor::port { "collectd_${collectd::params::protocol}_${collectd::params::port}": 
        protocol => "${collectd::params::protocol}",
        port     => "${collectd::params::port}",
        target   => "${collectd::params::monitor_target_real}",
        enable   => "${collectd::params::monitor_port_enable}",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "collectd_url":
        url      => "${collectd::params::monitor_baseurl_real}/index.php",
        pattern  => "${collectd::params::monitor_url_pattern}",
        enable   => "${collectd::params::monitor_url_enable}",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "collectd_process":
        process  => "${collectd::params::processname}",
        service  => "${collectd::params::servicename}",
        pidfile  => "${collectd::params::pidfile}",
        enable   => "${collectd::params::monitor_process_enable}",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "collectd_plugin":
        plugin   => "collectd",
        enable   => "${collectd::params::monitor_plugin_enable}",
        tool     => "${monitor_tool}",
    }

    # Include project specific class if $my_project is set
    if $my_project { include "collectd::${my_project}::monitor" }

}
