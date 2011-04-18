# Class: nfs::monitor
#
# Monitors nfs process/ports/service using Example42 monitor meta module (to be adapted to custom monitor solutions)
# It's automatically included and used if $monitor=yes and is defined at least one monitoring software in $monitor_tool
# This class permits to abstract what you want to monitor from the actual tool and modules you'll use for monitoring
# and can be used to quickly deploy a new monitoring solution that instantly notifies what's working and what's needs
# to be fixed (call it Test Driven Puppet Deployment, if you like ;-)
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $nfs_monitor_port (true|false) : Set if you want to monitor nfs's port(s). If any. Default: As defined in $monitor_port
# $nfs_monitor_url (true|false) : Set if you want to monitor nfs's url(s). If any. Default: As defined in $monitor_url
# $nfs_monitor_process (true|false) : Set if you want to monitor nfs's process. If any. Default: As defined in $monitor_process
# $nfs_monitor_plugin (true|false) : Set if you want to monitor nfs using specific monitor tool's plugin  i   s. If any. Default: As defined in $monitor_plugin
# $nfs_monitor_target : Define how to reach (Ip, fqdn...) the host to monitor nfs from an external server. Default: As defined in $monitor_target
# $nfs_monitor_url : Define the baseurl (http://$fqdn/...) to use for eventual nfs URL checks. Default: As defined in $monitor_url
# 
# You can therefore set site wide variables that can be overriden by the above module specific ones:
# $monitor_port (true|false) : Set if you want to enable port monitoring site-wide.
# $monitor_url (true|false) : Set if you want to enable url checking site-wide.
# $monitor_process (true|false) : Set if you want to enable process monitoring site-wide.
# $monitor_plugin (true|false) : Set if you want to try to use specific plugins of your monitoring tools 
# $monitor_target : Set the ip/hostname you want to use on an external monitoring server to monitor this host
# $monitor_baseurl : Set baseurl to use for eventual URL checks of services provided by this host
# For the defaults of the above variables check nfs::params
#
# Usage:
# Automatically included if $monitor=yes
# Use the variable $monitor_tool (can be an array) to define the monitoring software you want to use.
# To customize specific and more granular behaviours use the above variables and eventually your custom modulename::monitor::$my_project class
#
class nfs::monitor {

    include nfs::params

    # Port monitoring
    monitor::port { "nfs_${nfs::params::protocol}_${nfs::params::port}": 
        protocol => "${nfs::params::protocol}",
        port     => "${nfs::params::port}",
        target   => "${nfs::params::monitor_target_real}",
        enable   => "${nfs::params::monitor_port_enable}",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "nfs_url":
        url      => "${nfs::params::monitor_baseurl_real}/index.php",
        pattern  => "${nfs::params::monitor_url_pattern}",
        enable   => "${nfs::params::monitor_url_enable}",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "nfs_process":
        process  => "${nfs::params::processname}",
        service  => "${nfs::params::servicename}",
        pidfile  => "${nfs::params::pidfile}",
        enable   => "${nfs::params::monitor_process_enable}",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "nfs_plugin":
        plugin   => "nfs",
        enable   => "${nfs::params::monitor_plugin_enable}",
        tool     => "${monitor_tool}",
    }

    # Include project specific monitor class if $my_project is set
    if $my_project { include "nfs::${my_project}::monitor" }

}
