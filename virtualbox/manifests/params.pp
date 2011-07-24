# Class: virtualbox::params
#
# Sets internal variables and defaults for virtualbox module
# This class is loaded in all the classes that use the values set here 
#
class virtualbox::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
# (The default used is in the line with '')

## Directory where to place a script or file to manage the autostart of VMs 
    $autostartdir = $virtualbox_autostartdir ? {
        ''      => "/etc/rc.local.d", # TODO Quick setup with dependency on example42 rclocal module
        default => "${virtualbox_autostartdir}",
    }


## EXTRA MODULE INTERNAL VARIABLES
#(add here module specific internal variables)



## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        centos => "VirtualBox-4.1",
        redhat => "VirtualBox-4.1",
        default => "virtualbox-4.1",
    }

    $servicename = $operatingsystem ? {
        default => "vboxdrv",
    }

    $servicename_web = $operatingsystem ? {
        default => "vboxweb-service",
    }

    $processname = $operatingsystem ? {
        default => "VBoxSVC",
    }

    $processname_web = $operatingsystem ? {
        default => "vboxwebsrv",
    }

    $hasstatus = $operatingsystem ? {
        default => true,
    }

    $configfile = $operatingsystem ? {
        default => "/etc/vbox/vbox.cfg",
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
        default => "/etc/vbox",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/virtualbox",
        ubuntu  => "/etc/default/virtualbox",
        default => "/etc/sysconfig/virtualbox",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        default => "/var/run/vboxd.pid",
    }

    $pidfile_web = $operatingsystem ? {
        redhat  => "/var/lock/subsys/vboxweb-service",
        suse    => "/var/lock/subsys/vboxweb-service",
        default => "/var/run/vboxweb-service",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        default => "/var/lib/virtualbox",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        default => "/var/log/vboxwebsrv.log",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "tcp"
    $port = "18083"
    


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) virtualbox::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $virtualbox_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $virtualbox_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$virtualbox_monitor_target",
    }

    # BaseUrl to access this service
    $monitor_baseurl_real = $virtualbox_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${virtualbox_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in virtualbox::monitor class
    $monitor_url_pattern = $virtualbox_monitor_url_pattern ? {
        ''      => "OK",
        default => "${virtualbox_monitor_url_pattern}",
    }

    # If virtualbox port monitoring is enabled 
    $monitor_port_enable = $virtualbox_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => true,
           default => $monitor_port,
        },
        default => $virtualbox_monitor_port,
    }

    # If virtualbox url monitoring is enabled 
    $monitor_url_enable = $virtualbox_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $virtualbox_monitor_url,
    }

    # If virtualbox process monitoring is enabled 
    $monitor_process_enable = $virtualbox_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $virtualbox_monitor_process,
    }

    # If virtualbox plugin monitoring is enabled 
    $monitor_plugin_enable = $virtualbox_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => false,
           default => $monitor_plugin,
        },
        default => $virtualbox_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) virtualbox::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $virtualbox_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$virtualbox_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $virtualbox_backup_frequency ? {
        ''      => "daily",
        default => "$virtualbox_backup_frequency",
    }

    # If virtualbox data have to be backed up
    $backup_data_enable = $virtualbox_backup_data ? {
        ''      => $backup_data ? {
           ''      => false,
           default => $backup_data,
        },
        default => $virtualbox_backup_data,
    }

    # If virtualbox logs have to be backed up
    $backup_log_enable = $virtualbox_backup_log ? {
        ''      => $backup_log ? {
           ''      => false,
           default => $backup_log,
        },
        default => $virtualbox_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) virtualbox::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $virtualbox_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$virtualbox_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $virtualbox_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$virtualbox_firewall_destination",
    }

    # If firewall filter is enabled
    $firewall_enable = $virtualbox_firewall_enable ? {
        ''      => $firewall_enable ? {
           ''      => true,
           default => $firewall_enable,
        },
        default => $virtualbox_firewall_enable,
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
