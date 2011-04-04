# Class: openvpn::params
#
# Sets internal variables and defaults for openvpn module
# This class is loaded in all the classes that use the values set here 
#
class openvpn::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
# (The default used is in the line with '')

## Example: Full hostname of openvpn server
#    $server = $openvpn_server ? {
#        ''      => "openvpn",
#        default => "${openvpn_server}",
#    }


## EXTRA MODULE INTERNAL VARIABLES
#(add here module specific internal variables)



## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        solaris => "CSWopenvpn",
        debian  => "openvpn",
        ubuntu  => "openvpn",
        default => "openvpn",
    }

    $servicename = $operatingsystem ? {
        debian  => "openvpn",
        ubuntu  => "openvpn",
        default => "openvpn",
    }

    $processname = $operatingsystem ? {
        default => "openvpn",
    }

    $hasstatus = $operatingsystem ? {
        debian  => false,
        ubuntu  => false,
        default => true,
    }

    $configfile = $operatingsystem ? {
        freebsd => "/usr/local/etc/openvpn/openvpn.conf",
        default => "/etc/openvpn/openvpn.conf",
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
        default => "/etc/openvpn",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/openvpn",
        ubuntu  => "/etc/default/openvpn",
        default => "/etc/sysconfig/openvpn",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        default => "/var/run/openvpn",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        default => "/usr/lib/openvpn",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        default => "/var/log/openvpn",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "tcp"
    $port = "1194"
    


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) openvpn::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $openvpn_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $openvpn_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$openvpn_monitor_target",
    }

    # BaseUrl to access this service
    $monitor_baseurl_real = $openvpn_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${openvpn_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in openvpn::monitor class
    $monitor_url_pattern = $openvpn_monitor_url_pattern ? {
        ''      => "OK",
        default => "${openvpn_monitor_url_pattern}",
    }

    # If openvpn port monitoring is enabled 
    $monitor_port_enable = $openvpn_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => false,
           default => $monitor_port,
        },
        default => $openvpn_monitor_port,
    }

    # If openvpn url monitoring is enabled 
    $monitor_url_enable = $openvpn_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $openvpn_monitor_url,
    }

    # If openvpn process monitoring is enabled 
    $monitor_process_enable = $openvpn_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => false,
           default => $monitor_process,
        },
        default => $openvpn_monitor_process,
    }

    # If openvpn plugin monitoring is enabled 
    $monitor_plugin_enable = $openvpn_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => false,
           default => $monitor_plugin,
        },
        default => $openvpn_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) openvpn::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $openvpn_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$openvpn_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $openvpn_backup_frequency ? {
        ''      => "daily",
        default => "$openvpn_backup_frequency",
    }

    # If openvpn data have to be backed up
    $backup_data_enable = $openvpn_backup_data ? {
        ''      => $backup_data ? {
           ''      => false,
           default => $backup_data,
        },
        default => $openvpn_backup_data,
    }

    # If openvpn logs have to be backed up
    $backup_log_enable = $openvpn_backup_log ? {
        ''      => $backup_log ? {
           ''      => false,
           default => $backup_log,
        },
        default => $openvpn_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) openvpn::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $openvpn_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$openvpn_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $openvpn_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$openvpn_firewall_destination",
    }

    # If firewall filter is enabled
    $firewall_enable = $openvpn_firewall_enable ? {
        ''      => $firewall_enable ? {
           ''      => false,
           default => $firewall_enable,
        },
        default => $openvpn_firewall_enable,
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
