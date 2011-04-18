# Class: openssh::monitor
#
# Monitors openssh process/ports/service using Example42 monitor meta module (to be adapted to custom monitor solutions)
# It's automatically included ad used if $monitor=yes
# This class permits to abstract what you want to monitor from the actual tool and modules you'll use for monitoring
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $openssh_monitor_port (true|false) : Set if you want to monitor openssh's port(s). If any. Default: As defined in $monitor_port
# $openssh_monitor_url (true|false) : Set if you want to monitor openssh's url(s). If any. Default: As defined in $monitor_url
# $openssh_monitor_process (true|false) : Set if you want to monitor openssh's process. If any. Default: As defined in $monitor_process
# $openssh_monitor_plugin (true|false) : Set if you want to monitor openssh using specific monitor tool's plugin  i   s. If any. Default: As defined in $monitor_plugin
# $openssh_monitor_target : Define how to reach (Ip, fqdn...) the host to monitor openssh from an external server. Default: As defined in $monitor_target
# $openssh_monitor_url : Define the baseurl (http://$fqdn/...) to use for eventual openssh URL checks. Default: As defined in $monitor_url
# 
# You can therefore set site wide variables that can be overriden by the above module specific ones:
# $monitor_port (true|false) : Set if you want to enable port monitoring site-wide.
# $monitor_url (true|false) : Set if you want to enable url checking site-wide.
# $monitor_process (true|false) : Set if you want to enable process monitoring site-wide.
# $monitor_plugin (true|false) : Set if you want to try to use specific plugins of your monitoring tools 
# $monitor_target : Set the ip/hostname you want to use on an external monitoring server to monitor this host
# $monitor_url : Setbaseurl to use for eventual URL checks of services provided by this host
# For the defaults of the above variables check openssh::params
#
# Usage:
# Automatically included if $monitor=yes
# Use the variable $monitor_tool (can be an array) to define the monitoring software you want to use.
# To customize specific and more granular behaviours use the above variables and eventually your custom modulename::monitor::$my_project class
#
class openssh::monitor {

    include openssh::params

    # Port monitoring
    monitor::port { "openssh_${openssh::params::protocol}_${openssh::params::port}": 
        protocol => "${openssh::params::protocol}",
        port     => "${openssh::params::port}",
        target   => "${openssh::params::monitor_target_real}",
        enable   => "${openssh::params::monitor_port_enable}",
        tool     => "${monitor_tool}",
    }

    # URL monitoring 
    monitor::url { "openssh_url":
        url      => "${openssh::params::monitor_baseurl_real}",
        pattern  => "${openssh::params::monitor_url_pattern}",
        enable   => "${openssh::params::monitor_url_enable}",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "openssh_process":
        process  => "${openssh::params::processname}",
        service  => "${openssh::params::servicename}",
        pidfile  => "${openssh::params::pidfile}",
        enable   => "${openssh::params::monitor_process_enable}",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "openssh_plugin":
        plugin   => "openssh",
        enable   => "${openssh::params::monitor_plugin_enable}",
        tool     => "${monitor_tool}",
    }

    # Include project specific monitor class if $my_project is set
    if $my_project { include "openssh::${my_project}::monitor" }

}

