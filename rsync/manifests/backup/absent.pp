# Class: rsync::backup::absent
#
# Remove rsync backup elements
#
class rsync::backup::absent {

    include rsync::params

    backup { "rsync_data": 
        frequency => "${rsync::params::backup_frequency}",
        path      => "${rsync::params::datadir}",
        enabled   => "false",
        target    => "${rsync::params::backup_target_real}",
    }
    
    backup { "rsync_logs": 
        frequency => "${rsync::params::backup_frequency}",
        path      => "${rsync::params::logdir}",
        enabled   => "false",
        target    => "${rsync::params::backup_target_real}",
    }

}
