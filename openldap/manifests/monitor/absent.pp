# Class: openldap::monitor::absent
#
# Remove openldap monitor elements
#
class openldap::monitor::absent {

    include openldap::params

    # Port monitoring
    monitor::port { "openldap_${openldap::params::protocol}_${openldap::params::port}": 
        protocol => "${openldap::params::protocol}",
        port     => "${openldap::params::port}",
        target   => "${openldap::params::monitor_target_real}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "openldap_url":
        url      => "${openldap::params::monitor_baseurl_real}/index.php",
        pattern  => "${openldap::params::monitor_url_pattern}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "openldap_process":
        process  => "${openldap::params::processname}",
        service  => "${openldap::params::servicename}",
        pidfile  => "${openldap::params::pidfile}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "openldap_plugin":
        plugin   => "openldap",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

}
