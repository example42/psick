# Class: mcollective::backup
#
# Backups mcollective data and logs using Example42 backup meta module (to be adapted to custom backup solutions)
# It's automatically included and used if $backup=yes
# This class permits to abstract what you want to backup from the tool and module to use for backups.
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $mcollective_backup_data (true|false) : Set if you want to backup mcollective's data. Default: As defined in $backup_data
# $mcollective_backup_log (true|false) : Set if you want to backup mcollective's logs. Default: As defined in $backup_log
# $mcollective_backup_frequency (hourly|daily|weekly|monthly) : Set the frequency of your mcollective backups. Default: daily.
# $mcollective_backup_target : Define how to reach (Ip, fqdn...) this host to backup mcollective from an external server. Default: As defined in $backup_target
# 
# You can also set some site wide variables that can be overriden by the above module specific ones:
# $backup_data (true|false) : Set if you want to enable data backups site-wide. 
# $backup_log (true|false) : Set if you want to enable logs backups site-wide. 
# $backup_target : Set the ip/hostname you want to use on an external backup server to backup this host
# For the defaults of the above variables check mcollective::params
#
# Usage:
# Automatically included if $backup=yes
#
class mcollective::backup {

    include mcollective::params

    backup { "mcollective_data": 
        frequency => "${mcollective::params::backup_frequency}",
        path      => "${mcollective::params::datadir}",
        enabled   => "${mcollective::params::backup_data_enable}",
        target    => "${mcollective::params::backup_target_real}",
    }
    
    backup { "mcollective_logs": 
        frequency => "${mcollective::params::backup_frequency}",
        path      => "${mcollective::params::logdir}",
        enabled   => "${mcollective::params::backup_log_enable}",
        target    => "${mcollective::params::backup_target_real}",
    }

}
