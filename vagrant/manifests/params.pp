# Class: vagrant::params
#
class vagrant::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
    $basedir = $vagrant_basedir ? {
        ''      => "/opt/vagrant",
        default => "${vagrant_basedir}",
    }

    $binpath = $operatingsystem ? {
        default => "/var/lib/gems/1.8/bin",
    }


## MODULE INTERNAL VARIABLES
    $packagename = $operatingsystem ? {
        default => "vagrant",
    }

    $processname = $operatingsystem ? {
        default => "vagrant",
    }
    
    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        default => "/var/log/vagrant",
    }



## DEFAULTS FOR MONITOR CLASS
    # How the monitor server refers to the monitor target 
    $monitor_target_real = $vagrant_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$vagrant_monitor_target",
    }

    # BaseUrl to access this service
    $monitor_baseurl_real = $vagrant_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${vagrant_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in vagrant::monitor class
    $monitor_url_pattern = $vagrant_monitor_url_pattern ? {
        ''      => "OK",
        default => "${vagrant_monitor_url_pattern}",
    }

    # If vagrant port monitoring is enabled 
    $monitor_port_enable = $vagrant_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => false,
           default => $monitor_port,
        },
        default => $vagrant_monitor_port,
    }

    # If vagrant url monitoring is enabled 
    $monitor_url_enable = $vagrant_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $vagrant_monitor_url,
    }

    # If vagrant process monitoring is enabled 
    $monitor_process_enable = $vagrant_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => false,
           default => $monitor_process,
        },
        default => $vagrant_monitor_process,
    }

    # If vagrant plugin monitoring is enabled 
    $monitor_plugin_enable = $vagrant_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => false,
           default => $monitor_plugin,
        },
        default => $vagrant_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) vagrant::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $vagrant_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$vagrant_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $vagrant_backup_frequency ? {
        ''      => "daily",
        default => "$vagrant_backup_frequency",
    }

    # If vagrant data have to be backed up
    $backup_data_enable = $vagrant_backup_data ? {
        ''      => $backup_data ? {
           ''      => false,
           default => $backup_data,
        },
        default => $vagrant_backup_data,
    }

    # If vagrant logs have to be backed up
    $backup_log_enable = $vagrant_backup_log ? {
        ''      => $backup_log ? {
           ''      => false,
           default => $backup_log,
        },
        default => $vagrant_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) vagrant::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $vagrant_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$vagrant_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $vagrant_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$vagrant_firewall_destination",
    }

    # If firewall filter is enabled
    $firewall_enable = $vagrant_firewall_enable ? {
        ''      => $firewall_enable ? {
           ''      => false,
           default => $firewall_enable,
        },
        default => $vagrant_firewall_enable,
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
