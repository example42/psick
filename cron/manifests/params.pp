# Class: cron::params
#
# Defines cron parameters
# In this class are defined as variables values that are used in other cron classes
# This class should be included, where necessary, and eventually be enhanced with support for more OS
#
class cron::params  {

    $packagename = $operatingsystem ? {
        /(?i:Ubuntu|Debian)/ => "cron",
        /(?i:CentOS|RedHat)/ => $lsbmajdistrelease ? {
            5    => "vixie-cron",
            6    => "cronie",
            default => "cronie",
        },
    }

    $servicename = $operatingsystem ? {
        /(?i:Ubuntu|Debian)/ => "cron",
        /(?i:CentOS|RedHat)/ => "crond",
    }

    $processname = $operatingsystem ? {
        /(?i:Ubuntu|Debian)/ => "cron",
        /(?i:CentOS|RedHat)/ => "crond",
    }

    $pidfile = $operatingsystem ? {
        default => "/var/run/crond.pid",
    }


    # If cron process monitoring is enabled 
    $monitor_process_enable = $cron_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $cron_monitor_process,
    }

}
