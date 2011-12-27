# Class: drupal::monitor
#
# Monitors drupal process/ports/service using Example42 monitor meta module (to be adapted to custom monitor solutions)
# It's automatically included and used if $monitor=yes and is defined at least one monitoring software in $monitor_tool
# This class permits to abstract what you want to monitor from the actual tool and modules you'll use for monitoring
# and can be used to quickly deploy a new monitoring solution that instantly notifies what's working and what's needs
# to be fixed (call it Test Driven Puppet Deployment, if you like ;-)
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $drupal_monitor_port (true|false) : Set if you want to monitor drupal's port(s). If any. Default: As defined in $monitor_port
# $drupal_monitor_url (true|false) : Set if you want to monitor drupal's url(s). If any. Default: As defined in $monitor_url
# $drupal_monitor_process (true|false) : Set if you want to monitor drupal's process. If any. Default: As defined in $monitor_process
# $drupal_monitor_plugin (true|false) : Set if you want to monitor drupal using specific monitor tool's plugin  i   s. If any. Default: As defined in $monitor_plugin
# $drupal_monitor_target : Define how to reach (Ip, fqdn...) the host to monitor drupal from an external server. Default: As defined in $monitor_target
# $drupal_monitor_url : Define the baseurl (http://$fqdn/...) to use for eventual drupal URL checks. Default: As defined in $monitor_url
# 
# You can therefore set site wide variables that can be overriden by the above module specific ones:
# $monitor_port (true|false) : Set if you want to enable port monitoring site-wide.
# $monitor_url (true|false) : Set if you want to enable url checking site-wide.
# $monitor_process (true|false) : Set if you want to enable process monitoring site-wide.
# $monitor_plugin (true|false) : Set if you want to try to use specific plugins of your monitoring tools 
# $monitor_target : Set the ip/hostname you want to use on an external monitoring server to monitor this host
# $monitor_baseurl : Set baseurl to use for eventual URL checks of services provided by this host
# For the defaults of the above variables check drupal::params
#
# Usage:
# Automatically included if $monitor=yes
# Use the variable $monitor_tool (can be an array) to define the monitoring software you want to use.
# To customize specific and more granular behaviours use the above variables and eventually your custom modulename::monitor::$my_project class
#
class drupal::monitor {

    include drupal::params

    # Port monitoring
    monitor::port { "drupal_${drupal::params::protocol}_${drupal::params::port}": 
        protocol => "${drupal::params::protocol}",
        port     => "${drupal::params::port}",
        target   => "${drupal::params::monitor_target_real}",
        enable   => "${drupal::params::monitor_port_enable}",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "drupal_url":
        url      => "${drupal::params::monitor_baseurl_real}/index.php",
        pattern  => "${drupal::params::monitor_url_pattern}",
        enable   => "${drupal::params::monitor_url_enable}",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "drupal_process":
        process  => "${drupal::params::processname}",
        service  => "${drupal::params::servicename}",
        pidfile  => "${drupal::params::pidfile}",
        enable   => "${drupal::params::monitor_process_enable}",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "drupal_plugin":
        plugin   => "drupal",
        enable   => "${drupal::params::monitor_plugin_enable}",
        tool     => "${monitor_tool}",
    }

    # Include project specific class if $my_project is set
    if $my_project { include "drupal::${my_project}::monitor" }

}
