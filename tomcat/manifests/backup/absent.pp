# Class: tomcat::backup::absent
#
# Remove tomcat backup elements
#
class tomcat::backup::absent {

    include tomcat::params

    backup { "tomcat_data": 
        frequency => "${tomcat::params::backup_frequency}",
        path      => "${tomcat::params::datadir}",
        enabled   => "false",
        target    => "${tomcat::params::backup_target_real}",
    }
    
    backup { "tomcat_logs": 
        frequency => "${tomcat::params::backup_frequency}",
        path      => "${tomcat::params::logdir}",
        enabled   => "false",
        target    => "${tomcat::params::backup_target_real}",
    }

}
