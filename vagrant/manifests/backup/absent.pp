# Class: vagrant::backup::absent
#
# Remove vagrant backup elements
#
class vagrant::backup::absent {

    include vagrant::params

    backup { "vagrant_data": 
        frequency => "${vagrant::params::backup_frequency}",
        path      => "${vagrant::params::datadir}",
        enabled   => "false",
        target    => "${vagrant::params::backup_target_real}",
    }
    
    backup { "vagrant_logs": 
        frequency => "${vagrant::params::backup_frequency}",
        path      => "${vagrant::params::logdir}",
        enabled   => "false",
        target    => "${vagrant::params::backup_target_real}",
    }

}
