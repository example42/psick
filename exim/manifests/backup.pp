# Class: exim::backup
#
# Backups exim data and logs using Example42 backup meta module (to be adapted to custom backup solutions)
# It's automatically included and used if $backup=yes
# This class permits to abstract what you want to backup from the tool and module to use for backups.
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $exim_backup_data (true|false) : Set if you want to backup exim's data. Default: As defined in $backup_data
# $exim_backup_log (true|false) : Set if you want to backup exim's logs. Default: As defined in $backup_log
# $exim_backup_frequency (hourly|daily|weekly|monthly) : Set the frequency of your exim backups. Default: daily.
# $exim_backup_target : Define how to reach (Ip, fqdn...) this host to backup exim from an external server. Default: As defined in $backup_target
# 
# You can also set some site wide variables that can be overriden by the above module specific ones:
# $backup_data (true|false) : Set if you want to enable data backups site-wide. 
# $backup_log (true|false) : Set if you want to enable logs backups site-wide. 
# $backup_target : Set the ip/hostname you want to use on an external backup server to backup this host
# For the defaults of the above variables check exim::params
#
# Usage:
# Automatically included if $backup=yes
#
class exim::backup {

    include exim::params

    backup { "exim_data": 
        frequency => "${exim::params::backup_frequency}",
        path      => "${exim::params::datadir}",
        enabled   => "${exim::params::backup_data_enable}",
        target    => "${exim::params::backup_target_real}",
    }
    
    backup { "exim_logs": 
        frequency => "${exim::params::backup_frequency}",
        path      => "${exim::params::logdir}",
        enabled   => "${exim::params::backup_log_enable}",
        target    => "${exim::params::backup_target_real}",
    }

    # Include project specific backup class if $my_project is set
    if $my_project { include "exim::${my_project}::backup" }

}
