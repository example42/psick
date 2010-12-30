# Class: samba::backup::absent
#
# Remove samba backup elements
#
class samba::backup::absent {

    include samba::params

    backup { "samba_data": 
        frequency => "${samba::params::backup_frequency}",
        path      => "${samba::params::datadir}",
        enabled   => "false",
        target    => "${samba::params::backup_target_real}",
    }
    
    backup { "samba_logs": 
        frequency => "${samba::params::backup_frequency}",
        path      => "${samba::params::logdir}",
        enabled   => "false",
        target    => "${samba::params::backup_target_real}",
    }

}
