# Class: varnish::monitor
#
# Monitors varnish process/ports/service using Example42 monitor meta module (to be adapted to custom monitor solutions)
# It's automatically included ad used if $monitor=yes and is defined at least one monitoring software in $monitor_tool
# This class permits to abstract what you want to monitor from the actual tool and modules you'll use for monitoring
# and can be used to quickly deploy a new monitoring solution
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $varnish_monitor_port (true|false) : Set if you want to monitor varnish's port(s). If any. Default: As defined in $monitor_port
# $varnish_monitor_url (true|false) : Set if you want to monitor varnish's url(s). If any. Default: As defined in $monitor_url
# $varnish_monitor_process (true|false) : Set if you want to monitor varnish's process. If any. Default: As defined in $monitor_process
# $varnish_monitor_plugin (true|false) : Set if you want to monitor varnish using specific monitor tool's plugin  i   s. If any. Default: As defined in $monitor_plugin
# $varnish_monitor_target : Define how to reach (Ip, fqdn...) the host to monitor varnish from an external server. Default: As defined in $monitor_target
# $varnish_monitor_url : Define the baseurl (http://$fqdn/...) to use for eventual varnish URL checks. Default: As defined in $monitor_url
# 
# You can therefore set site wide variables that can be overriden by the above module specific ones:
# $monitor_port (true|false) : Set if you want to enable port monitoring site-wide.
# $monitor_url (true|false) : Set if you want to enable url checking site-wide.
# $monitor_process (true|false) : Set if you want to enable process monitoring site-wide.
# $monitor_plugin (true|false) : Set if you want to try to use specific plugins of your monitoring tools 
# $monitor_target : Set the ip/hostname you want to use on an external monitoring server to monitor this host
# $monitor_baseurl : Set baseurl to use for eventual URL checks of services provided by this host
# For the defaults of the above variables check varnish::params
#
# Usage:
# Automatically included if $monitor=yes
# Use the variable $monitor_tool (can be an array) to define the monitoring software you want to use.
# To customize specific and more granular behaviours use the above variables and eventually your custom modulename::monitor::$my_project class
#
class varnish::monitor {

    include varnish::params

    # Port monitoring
    monitor::port { "varnish_${varnish::params::protocol}_${varnish::params::port}": 
        protocol => "${varnish::params::protocol}",
        port     => "${varnish::params::port}",
        target   => "${varnish::params::monitor_target_real}",
        enable   => "${varnish::params::monitor_port_enable}",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "varnish_url":
        url      => "${varnish::params::monitor_baseurl_real}/index.php",
        pattern  => "${varnish::params::monitor_url_pattern}",
        enable   => "${varnish::params::monitor_url_enable}",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "varnish_process":
        process  => "${varnish::params::processname}",
        service  => "${varnish::params::servicename}",
        pidfile  => "${varnish::params::pidfile}",
        enable   => "${varnish::params::monitor_process_enable}",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "varnish_plugin":
        plugin   => "varnish",
        enable   => "${varnish::params::monitor_plugin_enable}",
        tool     => "${monitor_tool}",
    }

    # Include project specific class if $my_project is set
    if $my_project { include "varnish::${my_project}::monitor" }

}
