# Class: vmware::params
#
# Sets internal variables and defaults for vmware module
# This class is loaded in all the classes that use the values set here 
#
class vmware::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
# (The default used is in the line with '')

## Example: Full hostname of vmware server
#    $server = $vmware_server ? {
#        ''      => "vmware",
#        default => "${vmware_server}",
#    }


## EXTRA MODULE INTERNAL VARIABLES
#(add here module specific internal variables)

    $processname_web = $operatingsystem ? {
        default => "webAccess",
    }

    $port_web = 9333 

## MODULE INTERNAL VARIABLEo
# (Modify to adapt to unsupported OSes)

# Quick setup for vmware server
    $packagename = $operatingsystem ? {
        default => "VMware-server",
    }

    $servicename = $operatingsystem ? {
        debian  => "vmware",
        ubuntu  => "vmware",
        default => "vmware",
    }

    $processname = $operatingsystem ? {
        default => "vmware-hostd",
    }

    $hasstatus = $operatingsystem ? {
        debian  => false,
        ubuntu  => false,
        default => true,
    }

    $configfile = $operatingsystem ? {
        default => "/etc/vmware/config",
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
        default => "/etc/vmware",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/vmware",
        ubuntu  => "/etc/default/vmware",
        default => "/etc/sysconfig/vmware",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        default => "/var/run/vmwared/vmware-hostd.pid",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        default => "/var/lib/vmware",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        default => "/var/log/vmware",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "tcp"
    $port = "902"
    


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) vmware::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $vmware_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $vmware_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$vmware_monitor_target",
    }

    # BaseUrl to access this service
    $monitor_baseurl_real = $vmware_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${vmware_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in vmware::monitor class
    $monitor_url_pattern = $vmware_monitor_url_pattern ? {
        ''      => "OK",
        default => "${vmware_monitor_url_pattern}",
    }

    # If vmware port monitoring is enabled 
    $monitor_port_enable = $vmware_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => true,
           default => $monitor_port,
        },
        default => $vmware_monitor_port,
    }

    # If vmware url monitoring is enabled 
    $monitor_url_enable = $vmware_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $vmware_monitor_url,
    }

    # If vmware process monitoring is enabled 
    $monitor_process_enable = $vmware_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $vmware_monitor_process,
    }

    # If vmware plugin monitoring is enabled 
    $monitor_plugin_enable = $vmware_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => false,
           default => $monitor_plugin,
        },
        default => $vmware_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) vmware::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $vmware_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$vmware_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $vmware_backup_frequency ? {
        ''      => "daily",
        default => "$vmware_backup_frequency",
    }

    # If vmware data have to be backed up
    $backup_data_enable = $vmware_backup_data ? {
        ''      => $backup_data ? {
           ''      => true,
           default => $backup_data,
        },
        default => $vmware_backup_data,
    }

    # If vmware logs have to be backed up
    $backup_log_enable = $vmware_backup_log ? {
        ''      => $backup_log ? {
           ''      => true,
           default => $backup_log,
        },
        default => $vmware_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) vmware::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $vmware_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$vmware_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $vmware_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$vmware_firewall_destination",
    }

    # If firewall filter is enabled
    $firewall_enable = $vmware_firewall_enable ? {
        ''      => $firewall_enable ? {
           ''      => true,
           default => $firewall_enable,
        },
        default => $vmware_firewall_enable,
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
