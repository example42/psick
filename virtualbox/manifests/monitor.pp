# Class: virtualbox::monitor
#
# Monitors virtualbox process/ports/service using Example42 monitor meta module (to be adapted to custom monitor solutions)
# It's automatically included and used if $monitor=yes and is defined at least one monitoring software in $monitor_tool
# This class permits to abstract what you want to monitor from the actual tool and modules you'll use for monitoring
# and can be used to quickly deploy a new monitoring solution that instantly notifies what's working and what's needs
# to be fixed (call it Test Driven Puppet Deployment, if you like ;-)
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $virtualbox_monitor_port (true|false) : Set if you want to monitor virtualbox's port(s). If any. Default: As defined in $monitor_port
# $virtualbox_monitor_url (true|false) : Set if you want to monitor virtualbox's url(s). If any. Default: As defined in $monitor_url
# $virtualbox_monitor_process (true|false) : Set if you want to monitor virtualbox's process. If any. Default: As defined in $monitor_process
# $virtualbox_monitor_plugin (true|false) : Set if you want to monitor virtualbox using specific monitor tool's plugin  i   s. If any. Default: As defined in $monitor_plugin
# $virtualbox_monitor_target : Define how to reach (Ip, fqdn...) the host to monitor virtualbox from an external server. Default: As defined in $monitor_target
# $virtualbox_monitor_url : Define the baseurl (http://$fqdn/...) to use for eventual virtualbox URL checks. Default: As defined in $monitor_url
# 
# You can therefore set site wide variables that can be overriden by the above module specific ones:
# $monitor_port (true|false) : Set if you want to enable port monitoring site-wide.
# $monitor_url (true|false) : Set if you want to enable url checking site-wide.
# $monitor_process (true|false) : Set if you want to enable process monitoring site-wide.
# $monitor_plugin (true|false) : Set if you want to try to use specific plugins of your monitoring tools 
# $monitor_target : Set the ip/hostname you want to use on an external monitoring server to monitor this host
# $monitor_baseurl : Set baseurl to use for eventual URL checks of services provided by this host
# For the defaults of the above variables check virtualbox::params
#
# Usage:
# Automatically included if $monitor=yes
# Use the variable $monitor_tool (can be an array) to define the monitoring software you want to use.
# To customize specific and more granular behaviours use the above variables and eventually your custom modulename::monitor::$my_project class
#
class virtualbox::monitor {

    include virtualbox::params

    # Port monitoring
    monitor::port { "virtualbox_${virtualbox::params::protocol}_${virtualbox::params::port}": 
        protocol => "${virtualbox::params::protocol}",
        port     => "${virtualbox::params::port}",
        target   => "${virtualbox::params::monitor_target_real}",
        enable   => "${virtualbox::params::monitor_port_enable}",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "virtualbox_url":
        url      => "${virtualbox::params::monitor_baseurl_real}/index.php",
        pattern  => "${virtualbox::params::monitor_url_pattern}",
        enable   => "${virtualbox::params::monitor_url_enable}",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "virtualbox_process":
        process  => "${virtualbox::params::processname}",
        service  => "${virtualbox::params::servicename}",
        pidfile  => "${virtualbox::params::pidfile}",
        enable   => "${virtualbox::params::monitor_process_enable}",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "virtualbox_plugin":
        plugin   => "virtualbox",
        enable   => "${virtualbox::params::monitor_plugin_enable}",
        tool     => "${monitor_tool}",
    }

    # Include project specific monitor class if $my_project is set
    if $my_project { include "virtualbox::${my_project}::monitor" }

}
