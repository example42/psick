# Class: snmpd::monitor
#
# Monitors snmpd process/ports/service using Example42 monitor meta module (to be adapted to custom monitor solutions)
# It's automatically included ad used if $monitor=yes
# This class permits to abstract what you want to monitor from the actual tool and modules you'll use for monitoring
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $snmpd_monitor_port (true|false) : Set if you want to monitor snmpd's port(s). If any. Default: As defined in $monitor_port
# $snmpd_monitor_url (true|false) : Set if you want to monitor snmpd's url(s). If any. Default: As defined in $monitor_url
# $snmpd_monitor_process (true|false) : Set if you want to monitor snmpd's process. If any. Default: As defined in $monitor_process
# $snmpd_monitor_plugin (true|false) : Set if you want to monitor snmpd using specific monitor tool's plugin  i   s. If any. Default: As defined in $monitor_plugin
# $snmpd_monitor_target : Define how to reach (Ip, fqdn...) the host to monitor snmpd from an external server. Default: As defined in $monitor_target
# $snmpd_monitor_url : Define the baseurl (http://$fqdn/...) to use for eventual snmpd URL checks. Default: As defined in $monitor_url
# 
# You can therefore set site wide variables that can be overriden by the above module specific ones:
# $monitor_port (true|false) : Set if you want to enable port monitoring site-wide.
# $monitor_url (true|false) : Set if you want to enable url checking site-wide.
# $monitor_process (true|false) : Set if you want to enable process monitoring site-wide.
# $monitor_plugin (true|false) : Set if you want to try to use specific plugins of your monitoring tools 
# $monitor_target : Set the ip/hostname you want to use on an external monitoring server to monitor this host
# $monitor_url : Setbaseurl to use for eventual URL checks of services provided by this host
# For the defaults of the above variables check snmpd::params
#
# Usage:
# Automatically included if $monitor=yes
# Use the variable $monitor_tool (can be an array) to define the monitoring software you want to use.
# To customize specific and more granular behaviours use the above variables and eventually your custom modulename::monitor::$my_project class
#
class snmpd::monitor {

    include snmpd::params

    # Port monitoring
    monitor::port { "snmpd_${snmpd::params::protocol}_${snmpd::params::port}": 
        protocol => "${snmpd::params::protocol}",
        port     => "${snmpd::params::port}",
        target   => "${snmpd::params::monitor_target_real}",
        enable   => "${snmpd::params::monitor_port_enable}",
        tool     => "${monitor_tool}",
    }

    # URL monitoring 
    monitor::url { "snmpd_url":
        url      => "${snmpd::params::monitor_baseurl_real}",
        pattern  => "${snmpd::params::monitor_url_pattern}",
        enable   => "${snmpd::params::monitor_url_enable}",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "snmpd_process":
        process  => "${snmpd::params::processname}",
        service  => "${snmpd::params::servicename}",
        pidfile  => "${snmpd::params::pidfile}",
        enable   => "${snmpd::params::monitor_process_enable}",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "snmpd_plugin":
        plugin   => "snmpd",
        enable   => "${snmpd::params::monitor_plugin_enable}",
        tool     => "${monitor_tool}",
    }

    # Include project specific class if $my_project is set
    if $my_project { include "snmpd::${my_project}::monitor" }

}
