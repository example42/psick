# Class: lighttpd::params
#
# Sets internal variables and defaults for lighttpd module
# This class is loaded in all the classes that use the values set here 
#
class lighttpd::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
# (The default used is in the line with '')

## Example: Full hostname of lighttpd server
#    $server = $lighttpd_server ? {
#        ''      => "lighttpd",
#        default => "${lighttpd_server}",
#    }


## EXTRA MODULE INTERNAL VARIABLES
#(add here module specific internal variables)



## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        default => "lighttpd",
    }

    $servicename = $operatingsystem ? {
        default => "lighttpd",
    }

    $processname = $operatingsystem ? {
        default => "lighttpd",
    }

    $hasstatus = $operatingsystem ? {
        debian  => false,
        ubuntu  => false,
        default => true,
    }

    $configfile = $operatingsystem ? {
        default => "/etc/lighttpd/lighttpd.conf",
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
        ubuntu  => "/etc/lighttpd/conf-enabled",
        debian  => "/etc/lighttpd/conf-enabled",
        centos  => "/etc/lighttpd/conf.d",
        redhat  => "/etc/lighttpd/conf.d",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/lighttpd",
        ubuntu  => "/etc/default/lighttpd",
        default => "/etc/sysconfig/lighttpd",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        default => "/var/run/lighttpdd.pid",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        redhat  => "/var/www/lighttpd",
        centos  => "/var/www/lighttpd",
        default => "/var/www",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        default => "/var/log/lighttpd",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "tcp"
    $port = "80"
    


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) lighttpd::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $lighttpd_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $lighttpd_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$lighttpd_monitor_target",
    }

    # BaseUrl to access this service
    $monitor_baseurl_real = $lighttpd_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${lighttpd_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in lighttpd::monitor class
    $monitor_url_pattern = $lighttpd_monitor_url_pattern ? {
        ''      => "OK",
        default => "${lighttpd_monitor_url_pattern}",
    }

    # If lighttpd port monitoring is enabled 
    $monitor_port_enable = $lighttpd_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => true,
           default => $monitor_port,
        },
        default => $lighttpd_monitor_port,
    }

    # If lighttpd url monitoring is enabled 
    $monitor_url_enable = $lighttpd_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $lighttpd_monitor_url,
    }

    # If lighttpd process monitoring is enabled 
    $monitor_process_enable = $lighttpd_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $lighttpd_monitor_process,
    }

    # If lighttpd plugin monitoring is enabled 
    $monitor_plugin_enable = $lighttpd_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => false,
           default => $monitor_plugin,
        },
        default => $lighttpd_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) lighttpd::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $lighttpd_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$lighttpd_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $lighttpd_backup_frequency ? {
        ''      => "daily",
        default => "$lighttpd_backup_frequency",
    }

    # If lighttpd data have to be backed up
    $backup_data_enable = $lighttpd_backup_data ? {
        ''      => $backup_data ? {
           ''      => true,
           default => $backup_data,
        },
        default => $lighttpd_backup_data,
    }

    # If lighttpd logs have to be backed up
    $backup_log_enable = $lighttpd_backup_log ? {
        ''      => $backup_log ? {
           ''      => true,
           default => $backup_log,
        },
        default => $lighttpd_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) lighttpd::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $lighttpd_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$lighttpd_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $lighttpd_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$lighttpd_firewall_destination",
    }

    # If firewall filter is enabled
    $firewall_enable = $lighttpd_firewall_enable ? {
        ''      => $firewall_enable ? {
           ''      => true,
           default => $firewall_enable,
        },
        default => $lighttpd_firewall_enable,
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
