# Class: vagrant::params
#
# Sets internal variables and defaults for vagrant module
# This class is loaded in all the classes that use the values set here 
#
class vagrant::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
# (The default used is in the line with '')

## Example: Full hostname of vagrant server
#    $server = $vagrant_server ? {
#        ''      => "vagrant",
#        default => "${vagrant_server}",
#    }


## EXTRA MODULE INTERNAL VARIABLES
#(add here module specific internal variables)



## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        solaris => "CSWvagrant",
        debian  => "vagrant",
        ubuntu  => "vagrant",
        default => "vagrant",
    }

    $servicename = $operatingsystem ? {
        debian  => "vagrant",
        ubuntu  => "vagrant",
        default => "vagrant",
    }

    $processname = $operatingsystem ? {
        default => "vagrant",
    }

    $hasstatus = $operatingsystem ? {
        debian  => false,
        ubuntu  => false,
        default => true,
    }

    $configfile = $operatingsystem ? {
        freebsd => "/usr/local/etc/vagrant/vagrant.conf",
        default => "/etc/vagrant/vagrant.conf",
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
        default => "/etc/vagrant",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/vagrant",
        ubuntu  => "/etc/default/vagrant",
        default => "/etc/sysconfig/vagrant",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        default => "/var/run/vagrantd.pid",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        default => "/var/lib/vagrant",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        default => "/var/log/vagrant",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "tcp"
    $port = "80"
    


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) vagrant::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $vagrant_monitor_target)

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
           ''      => true,
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
           ''      => true,
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
           ''      => true,
           default => $backup_data,
        },
        default => $vagrant_backup_data,
    }

    # If vagrant logs have to be backed up
    $backup_log_enable = $vagrant_backup_log ? {
        ''      => $backup_log ? {
           ''      => true,
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
           ''      => true,
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
