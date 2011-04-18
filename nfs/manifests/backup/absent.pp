# Class: nfs::backup::absent
#
# Remove nfs backup elements
#
class nfs::backup::absent {

    include nfs::params

    backup { "nfs_data": 
        frequency => "${nfs::params::backup_frequency}",
        path      => "${nfs::params::datadir}",
        enabled   => "false",
        target    => "${nfs::params::backup_target_real}",
    }
    
    backup { "nfs_logs": 
        frequency => "${nfs::params::backup_frequency}",
        path      => "${nfs::params::logdir}",
        enabled   => "false",
        target    => "${nfs::params::backup_target_real}",
    }

}
