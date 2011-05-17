# Class: vmware::backup::absent
#
# Remove vmware backup elements
#
class vmware::backup::absent {

    include vmware::params

    backup { "vmware_data": 
        frequency => "${vmware::params::backup_frequency}",
        path      => "${vmware::params::datadir}",
        enabled   => "false",
        target    => "${vmware::params::backup_target_real}",
    }
    
    backup { "vmware_logs": 
        frequency => "${vmware::params::backup_frequency}",
        path      => "${vmware::params::logdir}",
        enabled   => "false",
        target    => "${vmware::params::backup_target_real}",
    }

}
