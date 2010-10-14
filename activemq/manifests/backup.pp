# Class: activemq::backup
#
# Backups activemq data and logs using Example42 backup meta module (to be adapted to custom backup solutions)
# It's automatically included and used if $backup=yes
# This class permits to abstract what you want to backup from the tool and module to use for backups.
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $activemq_backup_data (true|false) : Set if you want to backup activemq's data. Default: As defined in $backup_data
# $activemq_backup_log (true|false) : Set if you want to backup activemq's logs. Default: As defined in $backup_log
# $activemq_backup_frequency (hourly|daily|weekly|monthly) : Set the frequency of your activemq backups. Default: daily.
# $activemq_backup_target : Define how to reach (Ip, fqdn...) this host to backup activemq from an external server. Default: As defined in $backup_target
# 
# You can also set some site wide variables that can be overriden by the above module specific ones:
# $backup_data (true|false) : Set if you want to enable data backups site-wide. 
# $backup_log (true|false) : Set if you want to enable logs backups site-wide. 
# $backup_target : Set the ip/hostname you want to use on an external backup server to backup this host
# For the defaults of the above variables check activemq::params
#
# Usage:
# Automatically included if $backup=yes
#
class activemq::backup {

    include activemq::params

    backup { "activemq_data": 
        frequency => "${activemq::params::backup_frequency}",
        path      => "${activemq::params::datadir}",
        enabled   => "${activemq::params::backup_data_enable}",
        target    => "${activemq::params::backup_target_real}",
    }
    
    backup { "activemq_logs": 
        frequency => "${activemq::params::backup_frequency}",
        path      => "${activemq::params::logdir}",
        enabled   => "${activemq::params::backup_log_enable}",
        target    => "${activemq::params::backup_target_real}",
    }

    # Include project specific backup class if $my_project is set
    if $my_project { 
        case $my_project_onmodule {
            yes,true: { include "${my_project}::activemq::backup" }
            default: { include "activemq::backup::${my_project}" }
        }
    }

}
