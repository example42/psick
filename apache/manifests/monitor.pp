# Class: apache::monitor
#
# Monitors apache process/ports/service using Example42 monitor meta module (to be adapted to custom monitor solutions)
# It's automatically included ad used if $monitor=yes
# This class permits to abstract what you want to monitor from the actual tool and modules you'll use for monitoring
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $apache_monitor_port (true|false) : Set if you want to monitor apache's port(s). If any. Default: As defined in $monitor_port
# $apache_monitor_url (true|false) : Set if you want to monitor apache's url(s). If any. Default: As defined in $monitor_url
# $apache_monitor_process (true|false) : Set if you want to monitor apache's process. If any. Default: As defined in $monitor_process
# $apache_monitor_plugin (true|false) : Set if you want to monitor apache using specific monitor tool's plugin  i   s. If any. Default: As defined in $monitor_plugin
# $apache_monitor_target : Define how to reach (Ip, fqdn...) the host to monitor apache from an external server. Default: As defined in $monitor_target
# $apache_monitor_url : Define the baseurl (http://$fqdn/...) to use for eventual apache URL checks. Default: As defined in $monitor_url
# 
# You can therefore set site wide variables that can be overriden by the above module specific ones:
# $monitor_port (true|false) : Set if you want to enable port monitoring site-wide.
# $monitor_url (true|false) : Set if you want to enable url checking site-wide.
# $monitor_process (true|false) : Set if you want to enable process monitoring site-wide.
# $monitor_plugin (true|false) : Set if you want to try to use specific plugins of your monitoring tools 
# $monitor_target : Set the ip/hostname you want to use on an external monitoring server to monitor this host
# $monitor_url : Setbaseurl to use for eventual URL checks of services provided by this host
# For the defaults of the above variables check apache::params
#
# Usage:
# Automatically included if $monitor=yes
# Use the variable $monitor_tool (can be an array) to define the monitoring software you want to use.
# To customize specific and more granular behaviours use the above variables and eventually your custom modulename::monitor::$my_project class
#
class apache::monitor {

    include apache::params

    # Port monitoring
    monitor::port { "apache_${apache::params::protocol}_${apache::params::port}": 
        protocol => "${apache::params::protocol}",
        port     => "${apache::params::port}",
        target   => "${apache::params::monitor_target_real}",
        enable   => "${apache::params::monitor_port_enable}",
        tool     => "${monitor_tool}",
    }

    # URL monitoring 
    monitor::url { "apache_url":
        url      => "${apache::params::monitor_baseurl_real}",
        pattern  => "${apache::params::monitor_url_pattern}",
        enable   => "${apache::params::monitor_url_enable}",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "apache_process":
        process  => "${apache::params::processname}",
        service  => "${apache::params::servicename}",
        pidfile  => "${apache::params::pidfile}",
        enable   => "${apache::params::monitor_process_enable}",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "apache_plugin":
        plugin   => "apache",
        enable   => "${apache::params::monitor_plugin_enable}",
        tool     => "${monitor_tool}",
    }

    # Include project specific monitor class if $my_project is set
    if $my_project { include "apache::${my_project}::monitor" }

}
