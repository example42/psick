# Class: portmap::backup::absent
#
# Remove portmap backup elements
#
class portmap::backup::absent {

    include portmap::params

    backup { "portmap_data": 
        frequency => "${portmap::params::backup_frequency}",
        path      => "${portmap::params::datadir}",
        enabled   => "false",
        target    => "${portmap::params::backup_target_real}",
    }
    
    backup { "portmap_logs": 
        frequency => "${portmap::params::backup_frequency}",
        path      => "${portmap::params::logdir}",
        enabled   => "false",
        target    => "${portmap::params::backup_target_real}",
    }

}
