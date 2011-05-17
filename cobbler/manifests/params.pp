# Class: cobbler::params
#
# Sets internal variables and defaults for cobbler module
# This class is loaded in all the classes that use the values set here 
#
class cobbler::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
# (The default used is in the line with '')

## Example: Full hostname of cobbler server
    $server = $cobbler_server ? {
        ''      => "cobbler",
        default => "${cobbler_server}",
    }


## EXTRA MODULE INTERNAL VARIABLES
#(add here module specific internal variables)

    $packagenameweb = $operatingsystem ? {
        default => "cobbler-web",
    }


## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        default => "cobbler",
    }

    $servicename = $operatingsystem ? {
        default => "cobblerd",
    }

    $processname = $operatingsystem ? {
        default => "cobblerd",
    }

    $hasstatus = $operatingsystem ? {
        default => true,
    }

    $configfile = $operatingsystem ? {
        default => "/etc/cobbler/settings",
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
        default => "/etc/cobbler",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/cobblerd",
        ubuntu  => "/etc/default/cobblerd",
        default => "/etc/sysconfig/cobblerd",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        default => "/var/run/cobblerd.pid",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        default => "/var/lib/cobbler",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        default => "/var/log/cobbler",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "tcp"
    $port = "25151"
    


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) cobbler::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $cobbler_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $cobbler_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$cobbler_monitor_target",
    }

    # BaseUrl to access this service
    $monitor_baseurl_real = $cobbler_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${cobbler_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in cobbler::monitor class
    $monitor_url_pattern = $cobbler_monitor_url_pattern ? {
        ''      => "OK",
        default => "${cobbler_monitor_url_pattern}",
    }

    # If cobbler port monitoring is enabled 
    $monitor_port_enable = $cobbler_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => true,
           default => $monitor_port,
        },
        default => $cobbler_monitor_port,
    }

    # If cobbler url monitoring is enabled 
    $monitor_url_enable = $cobbler_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $cobbler_monitor_url,
    }

    # If cobbler process monitoring is enabled 
    $monitor_process_enable = $cobbler_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $cobbler_monitor_process,
    }

    # If cobbler plugin monitoring is enabled 
    $monitor_plugin_enable = $cobbler_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => false,
           default => $monitor_plugin,
        },
        default => $cobbler_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) cobbler::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $cobbler_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$cobbler_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $cobbler_backup_frequency ? {
        ''      => "daily",
        default => "$cobbler_backup_frequency",
    }

    # If cobbler data have to be backed up
    $backup_data_enable = $cobbler_backup_data ? {
        ''      => $backup_data ? {
           ''      => true,
           default => $backup_data,
        },
        default => $cobbler_backup_data,
    }

    # If cobbler logs have to be backed up
    $backup_log_enable = $cobbler_backup_log ? {
        ''      => $backup_log ? {
           ''      => true,
           default => $backup_log,
        },
        default => $cobbler_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) cobbler::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $cobbler_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$cobbler_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $cobbler_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$cobbler_firewall_destination",
    }

    # If firewall filter is enabled
    $firewall_enable = $cobbler_firewall_enable ? {
        ''      => $firewall_enable ? {
           ''      => true,
           default => $firewall_enable,
        },
        default => $cobbler_firewall_enable,
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
