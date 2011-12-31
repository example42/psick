# Class: tomcat::backup
#
# Backups tomcat data and logs using Example42 backup meta module (to be adapted to custom backup solutions)
# It's automatically included and used if $backup=yes
# This class permits to abstract what you want to backup from the tool and module to use for backups.
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $tomcat_backup_data (true|false) : Set if you want to backup tomcat's data. Default: As defined in $backup_data
# $tomcat_backup_log (true|false) : Set if you want to backup tomcat's logs. Default: As defined in $backup_log
# $tomcat_backup_frequency (hourly|daily|weekly|monthly) : Set the frequency of your tomcat backups. Default: daily.
# $tomcat_backup_target : Define how to reach (Ip, fqdn...) this host to backup tomcat from an external server. Default: As defined in $backup_target
# 
# You can also set some site wide variables that can be overriden by the above module specific ones:
# $backup_data (true|false) : Set if you want to enable data backups site-wide. 
# $backup_log (true|false) : Set if you want to enable logs backups site-wide. 
# $backup_target : Set the ip/hostname you want to use on an external backup server to backup this host
# For the defaults of the above variables check tomcat::params
#
# Usage:
# Automatically included if $backup=yes
#
class tomcat::backup {

    include tomcat::params

    backup { "tomcat_data": 
        frequency => "${tomcat::params::backup_frequency}",
        path      => "${tomcat::params::datadir}",
        enabled   => "${tomcat::params::backup_data_enable}",
        target    => "${tomcat::params::backup_target_real}",
    }
    
    backup { "tomcat_logs": 
        frequency => "${tomcat::params::backup_frequency}",
        path      => "${tomcat::params::logdir}",
        enabled   => "${tomcat::params::backup_log_enable}",
        target    => "${tomcat::params::backup_target_real}",
    }

}
