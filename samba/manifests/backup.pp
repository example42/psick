# Class: samba::backup
#
# Backups samba data and logs using Example42 backup meta module (to be adapted to custom backup solutions)
# It's automatically included and used if $backup=yes
# This class permits to abstract what you want to backup from the tool and module to use for backups.
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $samba_backup_data (true|false) : Set if you want to backup samba's data. Default: As defined in $backup_data
# $samba_backup_log (true|false) : Set if you want to backup samba's logs. Default: As defined in $backup_log
# $samba_backup_frequency (hourly|daily|weekly|monthly) : Set the frequency of your samba backups. Default: daily.
# $samba_backup_target : Define how to reach (Ip, fqdn...) this host to backup samba from an external server. Default: As defined in $backup_target
# 
# You can also set some site wide variables that can be overriden by the above module specific ones:
# $backup_data (true|false) : Set if you want to enable data backups site-wide. 
# $backup_log (true|false) : Set if you want to enable logs backups site-wide. 
# $backup_target : Set the ip/hostname you want to use on an external backup server to backup this host
# For the defaults of the above variables check samba::params
#
# Usage:
# Automatically included if $backup=yes
#
class samba::backup {

    include samba::params

    backup { "samba_data": 
        frequency => "${samba::params::backup_frequency}",
        path      => "${samba::params::datadir}",
        enabled   => "${samba::params::backup_data_enable}",
        target    => "${samba::params::backup_target_real}",
    }
    
    backup { "samba_logs": 
        frequency => "${samba::params::backup_frequency}",
        path      => "${samba::params::logdir}",
        enabled   => "${samba::params::backup_log_enable}",
        target    => "${samba::params::backup_target_real}",
    }

}
