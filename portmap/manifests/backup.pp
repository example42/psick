# Class: portmap::backup
#
# Backups portmap data and logs using Example42 backup meta module (to be adapted to custom backup solutions)
# It's automatically included and used if $backup=yes
# This class permits to abstract what you want to backup from the tool and module to use for backups.
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $portmap_backup_data (true|false) : Set if you want to backup portmap's data. Default: As defined in $backup_data
# $portmap_backup_log (true|false) : Set if you want to backup portmap's logs. Default: As defined in $backup_log
# $portmap_backup_frequency (hourly|daily|weekly|monthly) : Set the frequency of your portmap backups. Default: daily.
# $portmap_backup_target : Define how to reach (Ip, fqdn...) this host to backup portmap from an external server. Default: As defined in $backup_target
# 
# You can also set some site wide variables that can be overriden by the above module specific ones:
# $backup_data (true|false) : Set if you want to enable data backups site-wide. 
# $backup_log (true|false) : Set if you want to enable logs backups site-wide. 
# $backup_target : Set the ip/hostname you want to use on an external backup server to backup this host
# For the defaults of the above variables check portmap::params
#
# Usage:
# Automatically included if $backup=yes
#
class portmap::backup {

    include portmap::params

    backup { "portmap_data": 
        frequency => "${portmap::params::backup_frequency}",
        path      => "${portmap::params::datadir}",
        enabled   => "${portmap::params::backup_data_enable}",
        target    => "${portmap::params::backup_target_real}",
    }
    
    backup { "portmap_logs": 
        frequency => "${portmap::params::backup_frequency}",
        path      => "${portmap::params::logdir}",
        enabled   => "${portmap::params::backup_log_enable}",
        target    => "${portmap::params::backup_target_real}",
    }

}
