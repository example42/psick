# Class: munin::backup::absent
#
# Remove munin backup elements
#
class munin::backup::absent {

    include munin::params

    backup { "munin_data": 
        frequency => "${munin::params::backup_frequency}",
        path      => "${munin::params::datadir}",
        enabled   => "false",
        target    => "${munin::params::backup_target_real}",
    }
    
    backup { "munin_logs": 
        frequency => "${munin::params::backup_frequency}",
        path      => "${munin::params::logdir}",
        enabled   => "false",
        target    => "${munin::params::backup_target_real}",
    }

}
