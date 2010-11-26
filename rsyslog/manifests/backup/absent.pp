# Class: rsyslog::backup::absent
#
# Remove rsyslog backup elements
#
class rsyslog::backup::absent {

    include rsyslog::params

    backup { "rsyslog_data": 
        frequency => "${rsyslog::params::backup_frequency}",
        path      => "${rsyslog::params::datadir}",
        enabled   => "false",
        target    => "${rsyslog::params::backup_target_real}",
    }
    
    backup { "rsyslog_logs": 
        frequency => "${rsyslog::params::backup_frequency}",
        path      => "${rsyslog::params::logdir}",
        enabled   => "false",
        target    => "${rsyslog::params::backup_target_real}",
    }

}
