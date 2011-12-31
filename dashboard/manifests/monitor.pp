# Class: dashboard::monitor
#
# Monitors dashboard process/ports/service using Example42 monitor meta module (to be adapted to custom monitor solutions)
# It's automatically included ad used if $monitor=yes
# This class permits to abstract what you want to monitor from the actual tool and modules you'll use for monitoring
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $dashboard_monitor_port (true|false) : Set if you want to monitor dashboard's port(s). If any. Default: As defined in $monitor_port
# $dashboard_monitor_url (true|false) : Set if you want to monitor dashboard's url(s). If any. Default: As defined in $monitor_url
# $dashboard_monitor_process (true|false) : Set if you want to monitor dashboard's process. If any. Default: As defined in $monitor_process
# $dashboard_monitor_plugin (true|false) : Set if you want to monitor dashboard using specific monitor tool's plugin  i   s. If any. Default: As defined in $monitor_plugin
# $dashboard_monitor_target : Define how to reach (Ip, fqdn...) the host to monitor dashboard from an external server. Default: As defined in $monitor_target
# $dashboard_monitor_url : Define the baseurl (http://$fqdn/...) to use for eventual dashboard URL checks. Default: As defined in $monitor_url
# 
# You can therefore set site wide variables that can be overriden by the above module specific ones:
# $monitor_port (true|false) : Set if you want to enable port monitoring site-wide.
# $monitor_url (true|false) : Set if you want to enable url checking site-wide.
# $monitor_process (true|false) : Set if you want to enable process monitoring site-wide.
# $monitor_plugin (true|false) : Set if you want to try to use specific plugins of your monitoring tools 
# $monitor_target : Set the ip/hostname you want to use on an external monitoring server to monitor this host
# $monitor_url : Setbaseurl to use for eventual URL checks of services provided by this host
# For the defaults of the above variables check dashboard::params
#
# Usage:
# Automatically included if $monitor=yes
# Use the variable $monitor_tool (can be an array) to define the monitoring software you want to use.
# To customize specific and more granular behaviours use the above variables and eventually your custom modulename::monitor::$my_project class
#
class dashboard::monitor {

    include dashboard::params

    # Port monitoring (only Puppetmaster)
if ($dashboard_server_local == true) or ($dashboard_server == "$fqdn") {
    monitor::port { "dashboard_${dashboard::params::protocol}_${dashboard::params::port}": 
        protocol => "${dashboard::params::protocol}",
        port     => "${dashboard::params::port}",
        target   => "${dashboard::params::monitor_target_real}",
        enable   => "${dashboard::params::monitor_port_enable}",
        tool     => "${monitor_tool}",
    }
}

    # URL monitoring 
    monitor::url { "dashboard_url":
        url      => "${dashboard::params::monitor_baseurl_real}",
        pattern  => "${dashboard::params::monitor_url_pattern}",
        enable   => "${dashboard::params::monitor_url_enable}",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "dashboard_process":
        process  => "ruby",
        argument => "${dashboard::params::processname}",
        service  => "${dashboard::params::servicename}",
        pidfile  => "${dashboard::params::pidfile}",
        enable   => "${dashboard::params::monitor_process_enable}",
        tool     => "${monitor_tool}",
    }

    # Process monitoring (only Puppetmaster)
if ($dashboard_server_local == true) or ($dashboard_server == "$fqdn") {
    monitor::process { "dashboardmaster_process":
        process  => "${dashboard::params::processname_server}",
        service  => "${dashboard::params::servicename_server}",
        pidfile  => "${dashboard::params::pidfile_server}",
        enable   => "${dashboard::params::monitor_process_enable}",
        tool     => "${monitor_tool}",
    }
}

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "dashboard_plugin":
        plugin   => "dashboard",
        enable   => "${dashboard::params::monitor_plugin_enable}",
        tool     => "${monitor_tool}",
    }

    # Include project specific monitor class if $my_project is set
    if $my_project { include "dashboard::${my_project}::monitor" }

}
