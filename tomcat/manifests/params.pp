# Class: tomcat::params
#
# Sets internal variables and defaults for tomcat module
# This class is loaded in all the classes that use the values set here 
#
class tomcat::params  {

    require common


## EXTRA MODULE INTERNAL VARIABLES
#(add here module specific internal variables)

    $packageversion = $operatingsystem ? {
        ubuntu  => "tomcat6",
        debian  => $common::osver ? {
            5    => "tomcat5.5",
            6    => "tomcat6",
         default => "tomcat6",
        },
        /(?i:CentOS|RedHat|Scientific)/ => $common::osver ? {
            5    => "tomcat5",
            6    => "tomcat6",
         default => "tomcat6",
        },
        default => "tomcat",
    }

    $webappsdir = $operatingsystem ? {
        default => "/usr/share/tomcat6/webapps",
    }


## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        default => "$packageversion",
    }

    $servicename = $operatingsystem ? {
        default => "$packageversion",
    }

    $processname = $operatingsystem ? {
        default => "java",
    }

    $hasstatus = $operatingsystem ? {
        default => true,
    }

#    $configfile = $operatingsystem ? {
#        default => "/etc/tomcat/tomcat.conf",
#    }

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
        default => "/etc/$packageversion",
    }

    $initconfigfile = $operatingsystem ? {
        ubuntu  => "/etc/default/$packageversion",
        debian  => "/etc/default/$packageversion",
        redhat  => "/etc/sysconfig/$packageversion",
        centos  => "/etc/sysconfig/$packageversion",
        default => "/etc/sysconfig/$packageversion",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        default => "/var/run/$version.pid",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        default => "/var/lib/$packageversion",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        default => "/var/log/$packageversion",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "tcp"
    $port = "8080"
    


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) tomcat::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $tomcat_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $tomcat_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$tomcat_monitor_target",
    }

    # BaseUrl to access this service
    $monitor_baseurl_real = $tomcat_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${tomcat_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in tomcat::monitor class
    $monitor_url_pattern = $tomcat_monitor_url_pattern ? {
        ''      => "OK",
        default => "${tomcat_monitor_url_pattern}",
    }

    # If tomcat port monitoring is enabled 
    $monitor_port_enable = $tomcat_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => true,
           default => $monitor_port,
        },
        default => $tomcat_monitor_port,
    }

    # If tomcat url monitoring is enabled 
    $monitor_url_enable = $tomcat_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $tomcat_monitor_url,
    }

    # If tomcat process monitoring is enabled 
    $monitor_process_enable = $tomcat_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $tomcat_monitor_process,
    }

    # If tomcat plugin monitoring is enabled 
    $monitor_plugin_enable = $tomcat_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => false,
           default => $monitor_plugin,
        },
        default => $tomcat_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) tomcat::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $tomcat_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$tomcat_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $tomcat_backup_frequency ? {
        ''      => "daily",
        default => "$tomcat_backup_frequency",
    }

    # If tomcat data have to be backed up
    $backup_data_enable = $tomcat_backup_data ? {
        ''      => $backup_data ? {
           ''      => true,
           default => $backup_data,
        },
        default => $tomcat_backup_data,
    }

    # If tomcat logs have to be backed up
    $backup_log_enable = $tomcat_backup_log ? {
        ''      => $backup_log ? {
           ''      => true,
           default => $backup_log,
        },
        default => $tomcat_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) tomcat::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $tomcat_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$tomcat_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $tomcat_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$tomcat_firewall_destination",
    }

    # If firewall filter is enabled
    $firewall_enable = $tomcat_firewall_enable ? {
        ''      => $firewall_enable ? {
           ''      => true,
           default => $firewall_enable,
        },
        default => $tomcat_firewall_enable,
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
