# Class: openssh::backup
#
# Backups openssh data and logs using Example42 backup meta module (to be adapted to custom backup solutions)
# It's automatically included and used if $backup=yes
# This class permits to abstract what you want to backup from the tool and module to use for backups.
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $openssh_backup_data (true|false) : Set if you want to backup openssh's data. Default: As defined in $backup_data
# $openssh_backup_log (true|false) : Set if you want to backup openssh's logs. Default: As defined in $backup_log
# $openssh_backup_frequency (hourly|daily|weekly|monthly) : Set the frequency of your openssh backups. Default: daily.
# $openssh_backup_target : Define how to reach (Ip, fqdn...) this host to backup openssh from an external server. Default: As defined in $backup_target
# 
# You can also set some site wide variables that can be overriden by the above module specific ones:
# $backup_data (true|false) : Set if you want to enable data backups site-wide. 
# $backup_log (true|false) : Set if you want to enable logs backups site-wide. 
# $backup_target : Set the ip/hostname you want to use on an external backup server to backup this host
# For the defaults of the above variables check openssh::params
#
# Usage:
# Automatically included if $backup=yes
#
class openssh::backup {

    include openssh::params

    backup { "openssh_data": 
        frequency => "${openssh::params::backup_frequency}",
        path      => "${openssh::params::datadir}",
        enabled   => "${openssh::params::backup_data_enable}",
        target    => "${openssh::params::backup_target_real}",
    }
    
    backup { "openssh_logs": 
        frequency => "${openssh::params::backup_frequency}",
        path      => "${openssh::params::logdir}",
        enabled   => "${openssh::params::backup_log_enable}",
        target    => "${openssh::params::backup_target_real}",
    }

}
