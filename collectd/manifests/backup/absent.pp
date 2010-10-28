# Class: collectd::backup::absent
#
# Remove collectd backup elements
#
class collectd::backup::absent {

    include collectd::params

    backup { "collectd_data": 
        frequency => "${collectd::params::backup_frequency}",
        path      => "${collectd::params::datadir}",
        enabled   => "false",
        target    => "${collectd::params::backup_target_real}",
    }
    
    backup { "collectd_logs": 
        frequency => "${collectd::params::backup_frequency}",
        path      => "${collectd::params::logdir}",
        enabled   => "false",
        target    => "${collectd::params::backup_target_real}",
    }

}
