# Class: monit::params
#
# Defines monit parameters
# In this class are defined as variables values that are used in other users classes
# This class should be included, where necessary, and eventually be enhanced with support for more OS
#
class monit::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
#
    $interval = $monit_interval ? {
        ''      => "120",
        default => $monit_interval,
    }

    $mailserver = $monit_mailserver ? {
        ''      => "localhost",
        default => $monit_mailserver,
    }

    $alert = $monit_alert ? {
        ''      => "root@example42.com",
        default => $monit_alert,
    }

    $startup = $monit_startup ? {
        ''      => "1",
        default => $monit_startup,
    }

# MODULES INTERNAL VARIABLES
# (Modify only to adapt to unsupported OSes)
    $packagename = $operatingsystem ? {
        default => "monit",
    }

    $servicename = $operatingsystem ? {
        default => "monit",
    }

    $servicepattern = $operatingsystem ? {
        default => "/usr/sbin/monit",
    }

    $hasstatus = $operatingsystem ? {
        /(?i:CentOS|RedHat|Scientific)/ => "true",
        default => "false",
    }

    $username = $operatingsystem ? {
        default => "root",
    }

    $configfile = $operatingsystem ? {
        /(?i:CentOS|RedHat|Scientific)/ => "/etc/monit.conf",
        default => "/etc/monit/monitrc",
    }

    $configfile_mode = $operatingsystem ? {
        default => "600",
    }

    $configfile_owner = $operatingsystem ? {
        default => "root",
    }

    $configfile_group = $operatingsystem ? {
        default => "root",
    }

    $initdconfigfile = $operatingsystem ? {
        /(?i:CentOS|RedHat|Scientific)/ => "/etc/sysconfig/monit",
        default => "/etc/default/monit",
    }

    $initdconfigfile_mode = $operatingsystem ? {
        default => "600",
    }

    $initdconfigfile_owner = $operatingsystem ? {
        default => "root",
    }

    $initdconfigfile_group = $operatingsystem ? {
        default => "root",
    }

    $pluginfile_mode = $operatingsystem ? {
        default => "600",
    }

    $pluginfile_owner = $operatingsystem ? {
        default => "root",
    }

    $pluginfile_group = $operatingsystem ? {
        default => "root",
    }

    $configdir = $operatingsystem ? {
        default => "/etc/monit",
    }

    $pluginsdir = $operatingsystem ? {
        default => "/etc/monit.d",
    }

    $pluginsdir_mode = $operatingsystem ? {
        default => "755",
    }

    $pluginsdir_owner = $operatingsystem ? {
        default => "root",
    }

    $pluginsdir_group = $operatingsystem ? {
        default => "root",
    }


    # Used by monitor class
    $pidfile = $operatingsystem ? {
        default => "/var/run/monit.pid",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        default => "/var/lib/monit",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        default => "/var/log/monit",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "tcp"
    $port = "0"



## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) monit::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $monit_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $monit_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$monit_monitor_target",
    }

    # BaseUrl to access this host
    $monitor_baseurl_real = $monit_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${monit_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in monit::monitor class
    $monitor_url_pattern = $monit_monitor_url_pattern ? {
        ''      => "OK",
        default => "${monit_monitor_url_pattern}",
    }

    # If monit port monitoring is enabled 
    $monitor_port_enable = $monit_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => false,
           default => $monitor_port,
        },
        default => $monit_monitor_port,
    }

    # If monit url monitoring is enabled 
    $monitor_url_enable = $monit_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $monit_monitor_url,
    }

    # If monit process monitoring is enabled 
    $monitor_process_enable = $monit_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $monit_monitor_process,
    }

    # If monit plugin monitoring is enabled 
    $monitor_plugin_enable = $monit_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => false,
           default => $monitor_plugin,
        },
        default => $monit_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) monit::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $monit_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$monit_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $monit_backup_frequency ? {
        ''      => "daily",
        default => "$monit_backup_frequency",
    }

    # If monit data have to be backed up
    $backup_data_enable = $monit_backup_data ? {
        ''      => $backup_data ? {
           ''      => false,
           default => $backup_data,
        },
        default => $monit_backup_data,
    }

    # If monit logs have to be backed up
    $backup_log_enable = $monit_backup_log ? {
        ''      => $backup_log ? {
           ''      => false,
           default => $backup_log,
        },
        default => $monit_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) monit::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $monit_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$monit_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $monit_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$monit_firewall_destination",
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
                /(^0.)/   => "puppet://$servername",
                default   => "puppet:///modules",
            }
        }
        default: { $general_base_source=$base_source }
    }


}
