# Class: dovecot::monitor::absent
#
# Remove dovecot monitor elements
#
class dovecot::monitor::absent {

    include dovecot::params

    # Port monitoring
    monitor::port { "dovecot_${dovecot::params::protocol}_${dovecot::params::port}": 
        protocol => "${dovecot::params::protocol}",
        port     => "${dovecot::params::port}",
        target   => "${dovecot::params::monitor_target_real}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "dovecot_url":
        url      => "${dovecot::params::monitor_baseurl_real}/index.php",
        pattern  => "${dovecot::params::monitor_url_pattern}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "dovecot_process":
        process  => "${dovecot::params::processname}",
        service  => "${dovecot::params::servicename}",
        pidfile  => "${dovecot::params::pidfile}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "dovecot_plugin":
        plugin   => "dovecot",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

}
