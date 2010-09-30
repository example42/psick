# Class: foo::monitor
#
# Monitors foo process/ports/service using Example42 monitor meta module (to be adapted to custom monitor solutions)
# It's automatically included ad used if $monitor=yes
# This class permits to abstract what you want to monitor from the actual tool and modules you'll use for monitoring
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $foo_monitor_port (true|false) : Set if you want to monitor foo's port(s). If any. Default: As defined in $monitor_port
# $foo_monitor_url (true|false) : Set if you want to monitor foo's url(s). If any. Default: As defined in $monitor_url
# $foo_monitor_process (true|false) : Set if you want to monitor foo's process. If any. Default: As defined in $monitor_process
# $foo_monitor_plugin (true|false) : Set if you want to monitor foo using specific monitor tool's plugin  i   s. If any. Default: As defined in $monitor_plugin
# $foo_monitor_target : Define how to reach (Ip, fqdn...) the host to monitor foo from an external server. Default: As defined in $monitor_target
# $foo_monitor_url : Define the baseurl (http://$fqdn/...) to use for eventual foo URL checks. Default: As defined in $monitor_url
# 
# You can therefore set site wide variables that can be overriden by the above module specific ones:
# $monitor_port (true|false) : Set if you want to enable port monitoring site-wide.
# $monitor_url (true|false) : Set if you want to enable url checking site-wide.
# $monitor_process (true|false) : Set if you want to enable process monitoring site-wide.
# $monitor_plugin (true|false) : Set if you want to try to use specific plugins of your monitoring tools 
# $monitor_target : Set the ip/hostname you want to use on an external monitoring server to monitor this host
# $monitor_url : Setbaseurl to use for eventual URL checks of services provided by this host
# For the defaults of the above variables check foo::params
#
# Usage:
# Automatically included if $monitor=yes
#
class foo::monitor {

    include foo::params

    # Port monitoring
    monitor::port { "foo_${foo::params::protocol}_${foo::params::port}": 
        protocol => "${foo::params::protocol}",
        port     => "${foo::params::port}",
        target   => "${foo::params::monitor_target_real}",
        enable   => "${foo::params::monitor_port_enable}",
    }
    
    # URL monitoring 
    monitor::url { "foo_url":
        url      => "${foo::params::monitor_baseurl_real}/index.php",
        pattern  => "${foo::params::monitor_url_pattern}",
        enable   => "${foo::params::monitor_url_enable}",
    }

    # Process monitoring 
    monitor::process { "foo_process":
        process  => "${foo::params::processname}",
        service  => "${foo::params::servicename}",
        pidfile  => "${foo::params::pidfile}",
        enable   => "${foo::params::monitor_process_enable}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "foo_plugin":
        plugin   => "foo",
        enable   => "${foo::params::monitor_plugin_enable}",
    }

    # Include project specific monitor class if $my_project is set
    if $my_project { 
        case $my_project_onmodule {
            yes,true: { include "${my_project}::foo::monitor" }
            default: { include "foo::monitor::${my_project}" }
        }
    }

}
