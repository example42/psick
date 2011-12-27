# Class: virtualbox::backup
#
# Backups virtualbox data and logs using Example42 backup meta module (to be adapted to custom backup solutions)
# It's automatically included and used if $backup=yes
# This class permits to abstract what you want to backup from the tool and module to use for backups.
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $virtualbox_backup_data (true|false) : Set if you want to backup virtualbox's data. Default: As defined in $backup_data
# $virtualbox_backup_log (true|false) : Set if you want to backup virtualbox's logs. Default: As defined in $backup_log
# $virtualbox_backup_frequency (hourly|daily|weekly|monthly) : Set the frequency of your virtualbox backups. Default: daily.
# $virtualbox_backup_target : Define how to reach (Ip, fqdn...) this host to backup virtualbox from an external server. Default: As defined in $backup_target
# 
# You can also set some site wide variables that can be overriden by the above module specific ones:
# $backup_data (true|false) : Set if you want to enable data backups site-wide. 
# $backup_log (true|false) : Set if you want to enable logs backups site-wide. 
# $backup_target : Set the ip/hostname you want to use on an external backup server to backup this host
# For the defaults of the above variables check virtualbox::params
#
# Usage:
# Automatically included if $backup=yes
#
class virtualbox::backup {

    include virtualbox::params

    backup { "virtualbox_data": 
        frequency => "${virtualbox::params::backup_frequency}",
        path      => "${virtualbox::params::datadir}",
        enabled   => "${virtualbox::params::backup_data_enable}",
        target    => "${virtualbox::params::backup_target_real}",
    }
    
    backup { "virtualbox_logs": 
        frequency => "${virtualbox::params::backup_frequency}",
        path      => "${virtualbox::params::logdir}",
        enabled   => "${virtualbox::params::backup_log_enable}",
        target    => "${virtualbox::params::backup_target_real}",
    }

}
