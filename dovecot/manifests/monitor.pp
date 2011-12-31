# Class: dovecot::monitor
#
# Monitors dovecot process/ports/service using Example42 monitor meta module (to be adapted to custom monitor solutions)
# It's automatically included ad used if $monitor=yes and is defined at least one monitoring software in $monitor_tool
# This class permits to abstract what you want to monitor from the actual tool and modules you'll use for monitoring
# and can be used to quickly deploy a new monitoring solution
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $dovecot_monitor_port (true|false) : Set if you want to monitor dovecot's port(s). If any. Default: As defined in $monitor_port
# $dovecot_monitor_url (true|false) : Set if you want to monitor dovecot's url(s). If any. Default: As defined in $monitor_url
# $dovecot_monitor_process (true|false) : Set if you want to monitor dovecot's process. If any. Default: As defined in $monitor_process
# $dovecot_monitor_plugin (true|false) : Set if you want to monitor dovecot using specific monitor tool's plugin  i   s. If any. Default: As defined in $monitor_plugin
# $dovecot_monitor_target : Define how to reach (Ip, fqdn...) the host to monitor dovecot from an external server. Default: As defined in $monitor_target
# $dovecot_monitor_url : Define the baseurl (http://$fqdn/...) to use for eventual dovecot URL checks. Default: As defined in $monitor_url
# 
# You can therefore set site wide variables that can be overriden by the above module specific ones:
# $monitor_port (true|false) : Set if you want to enable port monitoring site-wide.
# $monitor_url (true|false) : Set if you want to enable url checking site-wide.
# $monitor_process (true|false) : Set if you want to enable process monitoring site-wide.
# $monitor_plugin (true|false) : Set if you want to try to use specific plugins of your monitoring tools 
# $monitor_target : Set the ip/hostname you want to use on an external monitoring server to monitor this host
# $monitor_baseurl : Set baseurl to use for eventual URL checks of services provided by this host
# For the defaults of the above variables check dovecot::params
#
# Usage:
# Automatically included if $monitor=yes
# Use the variable $monitor_tool (can be an array) to define the monitoring software you want to use.
# To customize specific and more granular behaviours use the above variables and eventually your custom modulename::monitor::$my_project class
#
class dovecot::monitor {

    include dovecot::params

    # Port monitoring
    monitor::port { "dovecot_${dovecot::params::protocol}_${dovecot::params::port}": 
        protocol => "${dovecot::params::protocol}",
        port     => "${dovecot::params::port}",
        target   => "${dovecot::params::monitor_target_real}",
        enable   => "${dovecot::params::monitor_port_enable}",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "dovecot_url":
        url      => "${dovecot::params::monitor_baseurl_real}/index.php",
        pattern  => "${dovecot::params::monitor_url_pattern}",
        enable   => "${dovecot::params::monitor_url_enable}",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "dovecot_process":
        process  => "${dovecot::params::processname}",
        service  => "${dovecot::params::servicename}",
        pidfile  => "${dovecot::params::pidfile}",
        enable   => "${dovecot::params::monitor_process_enable}",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "dovecot_plugin":
        plugin   => "dovecot",
        enable   => "${dovecot::params::monitor_plugin_enable}",
        tool     => "${monitor_tool}",
    }

    # Include project specific class if $my_project is set
    if $my_project { include "dovecot::${my_project}::monitor" }

}
