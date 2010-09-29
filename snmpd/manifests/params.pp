# Class: snmpd::params
#
# Sets internal variables and defaults for snmpd module
# This class is automatically loaded in all the classes that use the values set here 
#
class snmpd::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
# (The default used is in the line with '')



## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        centos  => "net-snmp",
        redhat  => "net-snmp",
        default => "snmpd",
    }

    $servicename = $operatingsystem ? {
        default => "snmpd",
    }

    $processname = $operatingsystem ? {
        default => "snmpd",
    }

    $hasstatus = $operatingsystem ? {
        debian  => false,
        ubuntu  => false,
        default => true,
    }

    $configfile = $operatingsystem ? {
        default => "/etc/snmp/snmpd.conf",
    }

    $configfile_mode = $operatingsystem ? {
        default => "644",
    }

    $configfile_owner = $operatingsystem ? {
        default => "root",
    }

    $configfile_group = $operatingsystem ? {
        default => "root",
    }

    $configdir = $operatingsystem ? {
        freebsd => "/usr/local/etc/snmpd/",
        default => "/etc/snmp",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/snmpd",
        ubuntu  => "/etc/default/snmpd",
        redhat  => "/etc/sysconfig/snmpd.options",
        centos  => "/etc/sysconfig/snmpd.options",
        default => "/etc/sysconfig/snmpd",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        default => "/var/run/snmpd.pid",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        default => "/usr/share/snmp",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        debian  => "/var/log/syslog",
        ubuntu  => "/var/log/syslog",
        default => "/var/log/messages",
    }



## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) snmpd::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $snmpd_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $snmpd_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$snmpd_monitor_target",
    }

    # BaseUrl to access this host
    $monitor_baseurl_real = $snmpd_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${snmpd_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in snmpd::monitor class
    $monitor_url_pattern = $snmpd_monitor_url_pattern ? {
        ''      => "OK",
        default => "${snmpd_monitor_url_pattern}",
    }

    # If snmpd port monitoring is enabled 
    $monitor_port_enable = $snmpd_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => true,
           default => $monitor_port,
        },
        default => $snmpd_monitor_port,
    }

    # If snmpd url monitoring is enabled 
    $monitor_url_enable = $snmpd_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $snmpd_monitor_url,
    }

    # If snmpd process monitoring is enabled 
    $monitor_process_enable = $snmpd_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $snmpd_monitor_process,
    }

    # If snmpd plugin monitoring is enabled 
    $monitor_plugin_enable = $snmpd_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => false,
           default => $monitor_plugin,
        },
        default => $snmpd_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) snmpd::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $snmpd_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$snmpd_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $snmpd_backup_frequency ? {
        ''      => "daily",
        default => "$snmpd_backup_frequency",
    }

    # If snmpd data have to be backed up
    $backup_data_enable = $snmpd_backup_data ? {
        ''      => $backup_data ? {
           ''      => false,
           default => $backup_data,
        },
        default => $snmpd_backup_data,
    }

    # If snmpd logs have to be backed up
    $backup_log_enable = $snmpd_backup_log ? {
        ''      => $backup_log ? {
           ''      => false,
           default => $backup_log,
        },
        default => $snmpd_backup_log,
    }


## FILE SERVING SOURCE
# Sets the correct source for static files
# In order to provide files from different sources without modifying the module
# you can override the default source path setting the variable $base_source
# Ex: $base_source="puppet://ip.of.fileserver" or $base_source="puppet://$servername/myprojectmodule"
# What follows automatically manages the new source standard (with /modules/) from 0.25 

    case $base_source {
        '': {
            $general_base_source = $puppetversion ? {
                /(^0.25)/ => "puppet:///modules",
                /(^0.)/   => "puppet:///",
                default   => "puppet:///modules",
            }
        }
        default: { $general_base_source=$base_source }
    }

}
