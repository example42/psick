# Class: lighttpd::backup::absent
#
# Remove lighttpd backup elements
#
class lighttpd::backup::absent {

    include lighttpd::params

    backup { "lighttpd_data": 
        frequency => "${lighttpd::params::backup_frequency}",
        path      => "${lighttpd::params::datadir}",
        enabled   => "false",
        target    => "${lighttpd::params::backup_target_real}",
    }
    
    backup { "lighttpd_logs": 
        frequency => "${lighttpd::params::backup_frequency}",
        path      => "${lighttpd::params::logdir}",
        enabled   => "false",
        target    => "${lighttpd::params::backup_target_real}",
    }

}
