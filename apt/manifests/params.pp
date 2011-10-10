# Class: apt::params
#
# Sets internal variables and defaults for apt module
# This class is loaded in all the classes that use the values set here 
#
class apt::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
# (The default used is in the line with '')

## Example: Full hostname of apt server
#    $server = $apt_server ? {
#        ''      => "apt",
#        default => "${apt_server}",
#    }


## EXTRA MODULE INTERNAL VARIABLES
#(add here module specific internal variables)



## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        debian  => "debconf-utils",
        ubuntu  => "debconf-utils",
        default => "debconf-utils",
    }

    $servicename = $operatingsystem ? {
        debian  => "apt",
        ubuntu  => "apt",
        default => "apt",
    }

    $processname = $operatingsystem ? {
        default => "apt",
    }

    $hasstatus = $operatingsystem ? {
        debian  => false,
        ubuntu  => false,
        default => true,
    }

    $configfile = $operatingsystem ? {
        default => "/etc/apt/apt.conf",
    }
    
    $confd_dir = $operatingsystem ? {
        default => "/etc/apt/apt.conf.d",
    }
    
    $sourcelist = $operatingsystem ? {
        default => "/etc/apt/sources.list",
    }
    
    $sourcelistdir = $operatingsystem ? {
        default => "/etc/apt/sources.list.d",
    }
    
    $configfile_mode = $operatingsystem ? {
        default => "644",
    }
    
    $update_command = $operatingsystem ? {
        default => "/usr/bin/apt-get -qq update",
    }
    
    $manage_preferences = $apt_manage_preferences ? {
       ""      => true,
       default => $apt_manage_preferences,
    }

    $manage_sourceslist = $apt_manage_sourceslist ? {
      ""      => true,
      default => $apt_manage_sourceslist,
    }
    
    $configdir_mode = $operatingsystem ? {
        default => "755",
    }
    
    $configfile_owner = $operatingsystem ? {
        default => "root",
    }

    $configfile_group = $operatingsystem ? {
        default => "root",
    }

    $configdir = $operatingsystem ? {
        default => "/etc/apt",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/apt",
        ubuntu  => "/etc/default/apt",
        default => "/etc/sysconfig/apt",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        default => "/var/run/aptd.pid",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        default => "/var/lib/apt",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        default => "/var/log/apt",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "tcp"
    $port = "80"
    


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) apt::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $apt_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $apt_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$apt_monitor_target",
    }

    # BaseUrl to access this service
    $monitor_baseurl_real = $apt_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${apt_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in apt::monitor class
    $monitor_url_pattern = $apt_monitor_url_pattern ? {
        ''      => "OK",
        default => "${apt_monitor_url_pattern}",
    }

    # If apt port monitoring is enabled 
    $monitor_port_enable = $apt_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => true,
           default => $monitor_port,
        },
        default => $apt_monitor_port,
    }

    # If apt url monitoring is enabled 
    $monitor_url_enable = $apt_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $apt_monitor_url,
    }

    # If apt process monitoring is enabled 
    $monitor_process_enable = $apt_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $apt_monitor_process,
    }

    # If apt plugin monitoring is enabled 
    $monitor_plugin_enable = $apt_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => false,
           default => $monitor_plugin,
        },
        default => $apt_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) apt::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $apt_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$apt_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $apt_backup_frequency ? {
        ''      => "daily",
        default => "$apt_backup_frequency",
    }

    # If apt data have to be backed up
    $backup_data_enable = $apt_backup_data ? {
        ''      => $backup_data ? {
           ''      => true,
           default => $backup_data,
        },
        default => $apt_backup_data,
    }

    # If apt logs have to be backed up
    $backup_log_enable = $apt_backup_log ? {
        ''      => $backup_log ? {
           ''      => true,
           default => $backup_log,
        },
        default => $apt_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) apt::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $apt_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$apt_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $apt_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$apt_firewall_destination",
    }

    # If firewall filter is enabled
    $firewall_enable = $apt_firewall_enable ? {
        ''      => $firewall_enable ? {
           ''      => true,
           default => $firewall_enable,
        },
        default => $apt_firewall_enable,
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
