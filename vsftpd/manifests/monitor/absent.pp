# Class: vsftpd::monitor::absent
#
# Remove vsftpd monitor elements
#
class vsftpd::monitor::absent {

    include vsftpd::params

    # Port monitoring
    monitor::port { "vsftpd_${vsftpd::params::protocol}_${vsftpd::params::port}": 
        protocol => "${vsftpd::params::protocol}",
        port     => "${vsftpd::params::port}",
        target   => "${vsftpd::params::monitor_target_real}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "vsftpd_url":
        url      => "${vsftpd::params::monitor_baseurl_real}/index.php",
        pattern  => "${vsftpd::params::monitor_url_pattern}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "vsftpd_process":
        process  => "${vsftpd::params::processname}",
        service  => "${vsftpd::params::servicename}",
        pidfile  => "${vsftpd::params::pidfile}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "vsftpd_plugin":
        plugin   => "vsftpd",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

}
