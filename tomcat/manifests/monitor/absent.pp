# Class: tomcat::monitor::absent
#
# Remove tomcat monitor elements
#
class tomcat::monitor::absent {

    include tomcat::params

    # Port monitoring
    monitor::port { "tomcat_${tomcat::params::protocol}_${tomcat::params::port}": 
        protocol => "${tomcat::params::protocol}",
        port     => "${tomcat::params::port}",
        target   => "${tomcat::params::monitor_target_real}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "tomcat_url":
        url      => "${tomcat::params::monitor_baseurl_real}/index.php",
        pattern  => "${tomcat::params::monitor_url_pattern}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "tomcat_process":
        process  => "${tomcat::params::processname}",
        service  => "${tomcat::params::servicename}",
        pidfile  => "${tomcat::params::pidfile}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "tomcat_plugin":
        plugin   => "tomcat",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

}
