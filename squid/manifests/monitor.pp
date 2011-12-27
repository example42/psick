# Class: squid::monitor
#
# Monitors squid process/ports/service using Example42 monitor meta module (to be adapted to custom monitor solutions)
# It's automatically included ad used if $monitor=yes
# This class permits to abstract what you want to monitor from the actual tool and modules you'll use for monitoring
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $squid_monitor_port (true|false) : Set if you want to monitor squid's port(s). If any. Default: As defined in $monitor_port
# $squid_monitor_url (true|false) : Set if you want to monitor squid's url(s). If any. Default: As defined in $monitor_url
# $squid_monitor_process (true|false) : Set if you want to monitor squid's process. If any. Default: As defined in $monitor_process
# $squid_monitor_plugin (true|false) : Set if you want to monitor squid using specific monitor tool's plugin  i   s. If any. Default: As defined in $monitor_plugin
# $squid_monitor_target : Define how to reach (Ip, fqdn...) the host to monitor squid from an external server. Default: As defined in $monitor_target
# $squid_monitor_url : Define the baseurl (http://$fqdn/...) to use for eventual squid URL checks. Default: As defined in $monitor_url
# 
# You can therefore set site wide variables that can be overriden by the above module specific ones:
# $monitor_port (true|false) : Set if you want to enable port monitoring site-wide.
# $monitor_url (true|false) : Set if you want to enable url checking site-wide.
# $monitor_process (true|false) : Set if you want to enable process monitoring site-wide.
# $monitor_plugin (true|false) : Set if you want to try to use specific plugins of your monitoring tools 
# $monitor_target : Set the ip/hostname you want to use on an external monitoring server to monitor this host
# $monitor_url : Setbaseurl to use for eventual URL checks of services provided by this host
# For the defaults of the above variables check squid::params
#
# Usage:
# Automatically included if $monitor=yes
#
class squid::monitor {

    include squid::params

    # Port monitoring
    monitor::port { "squid_${squid::params::protocol}_${squid::params::port}": 
        protocol => "${squid::params::protocol}",
        port     => "${squid::params::port}",
        target   => "${squid::params::monitor_target_real}",
        enable   => "${squid::params::monitor_port_enable}",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "squid_url":
        url      => "${squid::params::monitor_baseurl_real}/index.php",
        pattern  => "${squid::params::monitor_url_pattern}",
        enable   => "${squid::params::monitor_url_enable}",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "squid_process":
        process  => "${squid::params::processname}",
        service  => "${squid::params::servicename}",
        pidfile  => "${squid::params::pidfile}",
        enable   => "${squid::params::monitor_process_enable}",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "squid_plugin":
        plugin   => "squid",
        enable   => "${squid::params::monitor_plugin_enable}",
        tool     => "${monitor_tool}",
    }

    # Include project specific monitor class if $my_project is set
    if $my_project { include "squid::${my_project}::monitor" }

}
