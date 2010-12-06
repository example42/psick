# Class: sysklogd::backup::absent
#
# Remove sysklogd backup elements
#
class sysklogd::backup::absent {

    include sysklogd::params

    backup { "sysklogd_data": 
        frequency => "${sysklogd::params::backup_frequency}",
        path      => "${sysklogd::params::datadir}",
        enabled   => "false",
        target    => "${sysklogd::params::backup_target_real}",
    }
    
    backup { "sysklogd_logs": 
        frequency => "${sysklogd::params::backup_frequency}",
        path      => "${sysklogd::params::logdir}",
        enabled   => "false",
        target    => "${sysklogd::params::backup_target_real}",
    }

}
