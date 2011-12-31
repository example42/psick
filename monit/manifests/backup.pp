# Class: monit::backup
#
# Backups monit data and logs using Example42 backup meta module (to be adapted to custom backup solutions)
# It's automatically included and used if $backup=yes
# This class permits to abstract what you want to backup from the tool and module to use for backups.
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $monit_backup_data (true|false) : Set if you want to backup monit's data. Default: As defined in $backup_data
# $monit_backup_log (true|false) : Set if you want to backup monit's logs. Default: As defined in $backup_log
# $monit_backup_frequency (hourly|daily|weekly|monthly) : Set the frequency of your monit backups. Default: daily.
# $monit_backup_target : Define how to reach (Ip, fqdn...) this host to backup monit from an external server. Default: As defined in $backup_target
# 
# You can also set some site wide variables that can be overriden by the above module specific ones:
# $backup_data (true|false) : Set if you want to enable data backups site-wide. 
# $backup_log (true|false) : Set if you want to enable logs backups site-wide. 
# $backup_target : Set the ip/hostname you want to use on an external backup server to backup this host
# For the defaults of the above variables check monit::params
#
# Usage:
# Automatically included if $backup=yes
#
class monit::backup {

    include monit::params

    backup { "monit_data": 
        frequency => "${monit::params::backup_frequency}",
        path      => "${monit::params::datadir}",
        enabled   => "${monit::params::backup_data_enable}",
        target    => "${monit::params::backup_target_real}",
    }
    
    backup { "monit_logs": 
        frequency => "${monit::params::backup_frequency}",
        path      => "${monit::params::logdir}",
        enabled   => "${monit::params::backup_log_enable}",
        target    => "${monit::params::backup_target_real}",
    }

}
