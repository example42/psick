# Class: collectd::params
#
# Sets internal variables and defaults for collectd module
# This class is automatically loaded in all the classes that use the values set here 
#
class collectd::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
# (The default used is in the line with '')

# Full hostname of collectd server
    $server = $collectd_server ? {
        ''      => "collectd",
        default => "${collectd_server}",
    }

# Define if collectd server is local (to manage network plugin)
# If $collectd_server = $fqdn then it's assumed to be local

   if ($collectd_server_local == true) or ($collectd_server_local == "yes") or ($collectd_server_local == "true") or ($collectd_server == "$fqdn") {
       $server_local = true
   }

# Listening Port of collectd
    $port = $collectd_port ? {
        ''      => "25826",
        default => "${collectd_port}",
    }


## EXTRA MODULE VARIABLES
    # Used by backup class
    $collectiondir = $operatingsystem ? {
        ubuntu  => "/usr/lib/cgi-bin",
        debian  => "/usr/lib/cgi-bin",
        centos  => "/var/www/cgi-bin",
        redhat  => "/var/www/cgi-bin",
    }

    $rrddir = $operatingsystem ? {
        ubuntu  => "/var/lib/collectd/rrd",
        debian  => "/var/lib/collectd/rrd",
        centos  => "/var/lib/collectd",
        redhat  => "/var/lib/collectd",
    }

    $libdir = $operatingsystem ? {
        default => "/usr/lib/collectd",
    }


## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        default => "collectd",
    }

    $servicename = $operatingsystem ? {
        default => "collectd",
    }

    $processname = $operatingsystem ? {
        default => "collectd",
    }

    $hasstatus = $operatingsystem ? {
        debian  => false,
        ubuntu  => false,
        default => true,
    }

    $configfile = $operatingsystem ? {
        centos  => "/etc/collectd.conf",
        redhat  => "/etc/collectd.conf",
        default => "/etc/collectd/collectd.conf",
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
        default => "/etc/collectd/collectd.d",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/collectd",
        ubuntu  => "/etc/default/collectd",
        default => "/etc/sysconfig/collectd",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        default => "/var/run/collectdmon.pid",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        default => "/var/lib/collectd",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        default => "/var/log/collectd",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "tcp"
    # $port is user configurable. Defined before    


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) collectd::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $collectd_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $collectd_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$collectd_monitor_target",
    }

    # BaseUrl to access this host
    $monitor_baseurl_real = $collectd_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${collectd_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in collectd::monitor class
    $monitor_url_pattern = $collectd_monitor_url_pattern ? {
        ''      => "OK",
        default => "${collectd_monitor_url_pattern}",
    }

    # If collectd port monitoring is enabled 
    $monitor_port_enable = $collectd_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => false,
           default => $monitor_port,
        },
        default => $collectd_monitor_port,
    }

    # If collectd url monitoring is enabled 
    $monitor_url_enable = $collectd_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $collectd_monitor_url,
    }

    # If collectd process monitoring is enabled 
    $monitor_process_enable = $collectd_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $collectd_monitor_process,
    }

    # If collectd plugin monitoring is enabled 
    $monitor_plugin_enable = $collectd_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => false,
           default => $monitor_plugin,
        },
        default => $collectd_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) collectd::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $collectd_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$collectd_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $collectd_backup_frequency ? {
        ''      => "daily",
        default => "$collectd_backup_frequency",
    }

    # If collectd data have to be backed up
    $backup_data_enable = $collectd_backup_data ? {
        ''      => $backup_data ? {
           ''      => true,
           default => $backup_data,
        },
        default => $collectd_backup_data,
    }

    # If collectd logs have to be backed up
    $backup_log_enable = $collectd_backup_log ? {
        ''      => $backup_log ? {
           ''      => false,
           default => $backup_log,
        },
        default => $collectd_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) collectd::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $collectd_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$collectd_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $collectd_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$collectd_firewall_destination",
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
