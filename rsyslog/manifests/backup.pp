# Class: rsyslog::backup
#
# Backups rsyslog data and logs using Example42 backup meta module (to be adapted to custom backup solutions)
# It's automatically included and used if $backup=yes
# This class permits to abstract what you want to backup from the tool and module to use for backups.
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $rsyslog_backup_data (true|false) : Set if you want to backup rsyslog's data. Default: As defined in $backup_data
# $rsyslog_backup_log (true|false) : Set if you want to backup rsyslog's logs. Default: As defined in $backup_log
# $rsyslog_backup_frequency (hourly|daily|weekly|monthly) : Set the frequency of your rsyslog backups. Default: daily.
# $rsyslog_backup_target : Define how to reach (Ip, fqdn...) this host to backup rsyslog from an external server. Default: As defined in $backup_target
# 
# You can also set some site wide variables that can be overriden by the above module specific ones:
# $backup_data (true|false) : Set if you want to enable data backups site-wide. 
# $backup_log (true|false) : Set if you want to enable logs backups site-wide. 
# $backup_target : Set the ip/hostname you want to use on an external backup server to backup this host
# For the defaults of the above variables check rsyslog::params
#
# Usage:
# Automatically included if $backup=yes
#
class rsyslog::backup {

    include rsyslog::params

    backup { "rsyslog_data": 
        frequency => "${rsyslog::params::backup_frequency}",
        path      => "${rsyslog::params::datadir}",
        enabled   => "${rsyslog::params::backup_data_enable}",
        target    => "${rsyslog::params::backup_target_real}",
    }
    
    backup { "rsyslog_logs": 
        frequency => "${rsyslog::params::backup_frequency}",
        path      => "${rsyslog::params::logdir}",
        enabled   => "${rsyslog::params::backup_log_enable}",
        target    => "${rsyslog::params::backup_target_real}",
    }

}
