# Class: nrpe::params
#
# Sets internal variables and defaults for nrpe module
# This class is automatically loaded in all the classes that use the values set here 
#
class nrpe::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
# (The default used is in the line with '')

# Full hostname of nrpe server
    $allowed_hosts = $nrpe_allowed_hosts ? {
        ''      => "127.0.0.1",
        default => "${nrpe_allowed_hosts}",
    }

    $port = $nrpe_port ? {
        ''      => "5666",
        default => "${nrpe_port}",
    }

    $dont_blame_nrpe = $nrpe_dont_blame_nrpe ? {
        ''      => "0",
        default => "${nrpe_dont_blame_nrpe}",
    }

    $use_ssl = $nrpe_use_ssl ? {
        ''      => "yes",
        default => "${nrpe_use_ssl}",
    }


## MODULE EXTRA VARIABLES
    $pluginsdir = $operatingsystem ? {
        /(centos|redhat)/ => $architecture ? {
            x86_64  => "/usr/lib64/nagios/plugins",
            default => "/usr/lib/nagios/plugins",
        },
        default => "/usr/lib/nagios/plugins",
    }

    $user = $operatingsystem ? {
        ubuntu  => "nagios",
        debian  => "nagios",
        default => "nrpe",
    }

## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        ubuntu  => "nagios-nrpe-server",
        debian  => "nagios-nrpe-server",
        default => "nrpe",
    }

    $servicename = $operatingsystem ? {
        ubuntu  => "nagios-nrpe-server",
        debian  => "nagios-nrpe-server",
        default => "nrpe",
    }

    $processname = $operatingsystem ? {
        default => "nrpe",
    }

    $hasstatus = $operatingsystem ? {
        debian  => false,
        ubuntu  => false,
        default => true,
    }

    $configfile = $operatingsystem ? {
        default => "/etc/nagios/nrpe.cfg",
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
        debian  => "/etc/nagios/nrpe.d",
        ubuntu  => "/etc/nagios/nrpe.d",
        default => "/etc/nrpe.d",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/nagios-nrpe-server",
        ubuntu  => "/etc/default/nagios-nrpe-server",
        default => "/etc/sysconfig/nrpe",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        redhat  => "/var/run/nrpe/nrpe.pid",
        centos  => "/var/run/nrpe/nrpe.pid",
        ubuntu  => "/var/run/nagios/nrpe.pid",
        default => "/var/run/nrpe.pid",
    }

    # Used by backup class
    $datadir = $configdir

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        default => "/var/log/messages",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "tcp"
    # DEFINED BEFORE UNDER USER VARIABLES # $port = "5666"
    


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) nrpe::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $nrpe_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $nrpe_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$nrpe_monitor_target",
    }

    # BaseUrl to access this host
    $monitor_baseurl_real = $nrpe_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${nrpe_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in nrpe::monitor class
    $monitor_url_pattern = $nrpe_monitor_url_pattern ? {
        ''      => "OK",
        default => "${nrpe_monitor_url_pattern}",
    }

    # If nrpe port monitoring is enabled 
    $monitor_port_enable = $nrpe_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => true,
           default => $monitor_port,
        },
        default => $nrpe_monitor_port,
    }

    # If nrpe url monitoring is enabled 
    $monitor_url_enable = $nrpe_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $nrpe_monitor_url,
    }

    # If nrpe process monitoring is enabled 
    $monitor_process_enable = $nrpe_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $nrpe_monitor_process,
    }

    # If nrpe plugin monitoring is enabled 
    $monitor_plugin_enable = $nrpe_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => false,
           default => $monitor_plugin,
        },
        default => $nrpe_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) nrpe::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $nrpe_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$nrpe_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $nrpe_backup_frequency ? {
        ''      => "daily",
        default => "$nrpe_backup_frequency",
    }

    # If nrpe data have to be backed up
    $backup_data_enable = $nrpe_backup_data ? {
        ''      => $backup_data ? {
           ''      => false,
           default => $backup_data,
        },
        default => $nrpe_backup_data,
    }

    # If nrpe logs have to be backed up
    $backup_log_enable = $nrpe_backup_log ? {
        ''      => $backup_log ? {
           ''      => false,
           default => $backup_log,
        },
        default => $nrpe_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) nrpe::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $nrpe_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$nrpe_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $nrpe_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$nrpe_firewall_destination",
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
