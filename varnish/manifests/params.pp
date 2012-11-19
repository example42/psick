# Class: varnish::params
#
# Sets internal variables and defaults for varnish module
# This class is automatically loaded in all the classes that use the values set here 
#
class varnish::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
# (The default used is in the line with '')

## Full hostname of varnish server
#    $server = $varnish_server ? {
#        ''      => "varnish",
#        default => "${varnish_server}",
#    }


## EXTRA MODULE INTERNAL VARIABLES
#(add here module specific internal variables)

    # Port to listen to for incoming connections
    $port = $varnish_port ? {
        ''      => "80",
        default => $varnish_port,
    }

    # Maximum number of open files (for ulimit -n)
    $nfiles = $varnish_nfiles ? {
        ''      => "131072",
        default => $varnish_nfiles,
    }

    # Maximum locked memory size (for ulimit -l)
    $memlock = $varnish_memlock ? {
        ''      => "82000",
        default => $varnish_memlock,
    }

    # Backend host
    $backendhost = $varnish_backendhost ? {
        ''      => "127.0.0.1",
        default => $varnish_backendhost,
    }

    # Backend port
    $backendport = $varnish_backendport ? {
        ''      => "8080",
        default => $varnish_backendport,
    }

## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        default => "varnish",
    }

    $servicename = $operatingsystem ? {
        default => "varnish",
    }

    $processname = $operatingsystem ? {
        default => "varnishd",
    }

    $hasstatus = $operatingsystem ? {
        default => false,
    }

    $template = $operatingsystem ? {
        default => "varnish/default.vcl.erb",
    }

    $configfile = $operatingsystem ? {
        default => "/etc/varnish/default.vcl",
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
        default => "/etc/varnish",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/varnish",
        ubuntu  => "/etc/default/varnish",
        default => "/etc/sysconfig/varnish",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        default => "/var/run/varnishd.pid",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        default => "/var/lib/varnish",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        default => "/var/log/varnish",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "tcp"
    


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) varnish::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $varnish_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $varnish_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$varnish_monitor_target",
    }

    # BaseUrl to access this host
    $monitor_baseurl_real = $varnish_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${varnish_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in varnish::monitor class
    $monitor_url_pattern = $varnish_monitor_url_pattern ? {
        ''      => "OK",
        default => "${varnish_monitor_url_pattern}",
    }

    # If varnish port monitoring is enabled 
    $monitor_port_enable = $varnish_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => true,
           default => $monitor_port,
        },
        default => $varnish_monitor_port,
    }

    # If varnish url monitoring is enabled 
    $monitor_url_enable = $varnish_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $varnish_monitor_url,
    }

    # If varnish process monitoring is enabled 
    $monitor_process_enable = $varnish_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $varnish_monitor_process,
    }

    # If varnish plugin monitoring is enabled 
    $monitor_plugin_enable = $varnish_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => true,
           default => $monitor_plugin,
        },
        default => $varnish_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) varnish::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $varnish_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$varnish_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $varnish_backup_frequency ? {
        ''      => "daily",
        default => "$varnish_backup_frequency",
    }

    # If varnish data have to be backed up
    $backup_data_enable = $varnish_backup_data ? {
        ''      => $backup_data ? {
           ''      => true,
           default => $backup_data,
        },
        default => $varnish_backup_data,
    }

    # If varnish logs have to be backed up
    $backup_log_enable = $varnish_backup_log ? {
        ''      => $backup_log ? {
           ''      => true,
           default => $backup_log,
        },
        default => $varnish_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) varnish::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $varnish_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$varnish_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $varnish_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$varnish_firewall_destination",
    }

    # If firewall filter is enabled
    $firewall_enable = $varnish_firewall_enable ? {
        ''      => $firewall_enable ? {
           ''      => true,
           default => $firewall_enable,
        },
        default => $varnish_firewall_enable,
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
