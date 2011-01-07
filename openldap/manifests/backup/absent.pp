# Class: openldap::backup::absent
#
# Remove openldap backup elements
#
class openldap::backup::absent {

    include openldap::params

    backup { "openldap_data": 
        frequency => "${openldap::params::backup_frequency}",
        path      => "${openldap::params::datadir}",
        enabled   => "false",
        target    => "${openldap::params::backup_target_real}",
    }
    
    backup { "openldap_logs": 
        frequency => "${openldap::params::backup_frequency}",
        path      => "${openldap::params::logdir}",
        enabled   => "false",
        target    => "${openldap::params::backup_target_real}",
    }

}
