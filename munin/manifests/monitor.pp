# Class: munin::monitor
#
# Monitors munin process/ports/service using Example42 monitor meta module (to be adapted to custom monitor solutions)
# It's automatically included ad used if $monitor=yes and is defined at least one monitoring software in $monitor_tool
# This class permits to abstract what you want to monitor from the actual tool and modules you'll use for monitoring
# and can be used to quickly deploy a new monitoring solution
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $munin_monitor_port (true|false) : Set if you want to monitor munin's port(s). If any. Default: As defined in $monitor_port
# $munin_monitor_url (true|false) : Set if you want to monitor munin's url(s). If any. Default: As defined in $monitor_url
# $munin_monitor_process (true|false) : Set if you want to monitor munin's process. If any. Default: As defined in $monitor_process
# $munin_monitor_plugin (true|false) : Set if you want to monitor munin using specific monitor tool's plugin  i   s. If any. Default: As defined in $monitor_plugin
# $munin_monitor_target : Define how to reach (Ip, fqdn...) the host to monitor munin from an external server. Default: As defined in $monitor_target
# $munin_monitor_url : Define the baseurl (http://$fqdn/...) to use for eventual munin URL checks. Default: As defined in $monitor_url
# 
# You can therefore set site wide variables that can be overriden by the above module specific ones:
# $monitor_port (true|false) : Set if you want to enable port monitoring site-wide.
# $monitor_url (true|false) : Set if you want to enable url checking site-wide.
# $monitor_process (true|false) : Set if you want to enable process monitoring site-wide.
# $monitor_plugin (true|false) : Set if you want to try to use specific plugins of your monitoring tools 
# $monitor_target : Set the ip/hostname you want to use on an external monitoring server to monitor this host
# $monitor_baseurl : Set baseurl to use for eventual URL checks of services provided by this host
# For the defaults of the above variables check munin::params
#
# Usage:
# Automatically included if $monitor=yes
# Use the variable $monitor_tool (can be an array) to define the monitoring software you want to use.
# To customize specific and more granular behaviours use the above variables and eventually your custom modulename::monitor::$my_project class
#
class munin::monitor {

    include munin::params

    # Port monitoring
    monitor::port { "munin_${munin::params::protocol}_${munin::params::port}": 
        protocol => "${munin::params::protocol}",
        port     => "${munin::params::port}",
        target   => "${munin::params::monitor_target_real}",
        enable   => "${munin::params::monitor_port_enable}",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "munin_url":
        url      => "${munin::params::monitor_baseurl_real}/index.php",
        pattern  => "${munin::params::monitor_url_pattern}",
        enable   => "${munin::params::monitor_url_enable}",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "munin_process":
        process  => "${munin::params::processname}",
        service  => "${munin::params::servicename}",
        pidfile  => "${munin::params::pidfile}",
        enable   => "${munin::params::monitor_process_enable}",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "munin_plugin":
        plugin   => "munin",
        enable   => "${munin::params::monitor_plugin_enable}",
        tool     => "${monitor_tool}",
    }

    # Include project specific monitor class if $my_project is set
    if $my_project { include "munin::${my_project}::monitor" }

}
