# Class: rsync::params
#
# Sets internal variables and defaults for rsync module
# This class is loaded in all the classes that use the values set here 
#
class rsync::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
# (The default used is in the line with '')

## Example: Full hostname of rsync server
#    $server = $rsync_server ? {
#        ''      => "rsync",
#        default => "${rsync_server}",
#    }


## EXTRA MODULE INTERNAL VARIABLES
#(add here module specific internal variables)



## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        solaris => "CSWrsync",
        default => "rsync",
    }

    $servicename = $operatingsystem ? {
        default => "rsync",
    }

    $processname = $operatingsystem ? {
        default => "rsync",
    }

    $hasstatus = $operatingsystem ? {
        debian  => false,
        ubuntu  => false,
        default => false,
    }

    $configfile = $operatingsystem ? {
        freebsd => "/usr/local/etc/rsync/rsync.conf",
        default => "/etc/rsyncd.conf",
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
        default => "/etc/rsync",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/rsync",
        ubuntu  => "/etc/default/rsync",
        default => "/etc/sysconfig/rsync",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        default => "/var/run/rsyncd.pid",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        default => "/var/lib/rsync",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        default => "/var/log/rsync.log",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "tcp"
    $port = "873"
    


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) rsync::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $rsync_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $rsync_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$rsync_monitor_target",
    }

    # BaseUrl to access this service
    $monitor_baseurl_real = $rsync_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${rsync_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in rsync::monitor class
    $monitor_url_pattern = $rsync_monitor_url_pattern ? {
        ''      => "OK",
        default => "${rsync_monitor_url_pattern}",
    }

    # If rsync port monitoring is enabled 
    $monitor_port_enable = $rsync_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => true,
           default => $monitor_port,
        },
        default => $rsync_monitor_port,
    }

    # If rsync url monitoring is enabled 
    $monitor_url_enable = $rsync_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $rsync_monitor_url,
    }

    # If rsync process monitoring is enabled 
    $monitor_process_enable = $rsync_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $rsync_monitor_process,
    }

    # If rsync plugin monitoring is enabled 
    $monitor_plugin_enable = $rsync_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => false,
           default => $monitor_plugin,
        },
        default => $rsync_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) rsync::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $rsync_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$rsync_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $rsync_backup_frequency ? {
        ''      => "daily",
        default => "$rsync_backup_frequency",
    }

    # If rsync data have to be backed up
    $backup_data_enable = $rsync_backup_data ? {
        ''      => $backup_data ? {
           ''      => true,
           default => $backup_data,
        },
        default => $rsync_backup_data,
    }

    # If rsync logs have to be backed up
    $backup_log_enable = $rsync_backup_log ? {
        ''      => $backup_log ? {
           ''      => true,
           default => $backup_log,
        },
        default => $rsync_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) rsync::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $rsync_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$rsync_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $rsync_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$rsync_firewall_destination",
    }

    # If firewall filter is enabled
    $firewall_enable = $rsync_firewall_enable ? {
        ''      => $firewall_enable ? {
           ''      => true,
           default => $firewall_enable,
        },
        default => $rsync_firewall_enable,
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
