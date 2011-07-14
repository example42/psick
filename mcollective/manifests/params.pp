# Class: mcollective::params
#
# Sets internal variables and defaults for mcollective module
# This class is automatically loaded in all the classes that use the values set here 
#
class mcollective::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
# (The default used is in the line with '')

    $client = $mcollective_client ? {
        ''      => "no",
        default => "${mcollective_client}",
    }

    $server = $mcollective_server ? {
        ''      => "yes",
        default => "${mcollective_server}",
    }

    $plugins = $mcollective_plugins ? {
        ''      => "yes",
        default => "${mcollective_plugins}",
    }



# Pre Shared Key (SET a Different ONE!)
    $psk = $mcollective_psk ? {
        ''      => "mcollective",
        default => "${mcollective_psk}",
    }

# Stomp settings
    $stomp_host = $mcollective_stomp_host ? {
        ''      => "stomp.example42.com",
        default => "${mcollective_stomp_host}",
    }

    $stomp_port = $mcollective_stomp_port ? {
        ''      => "6163",
        default => "${mcollective_stomp_port}",
    }

    $stomp_user = $mcollective_stomp_user ? {
        ''      => "mcollective",
        default => "${mcollective_stomp_user}",
    }

    $stomp_password = $mcollective_stomp_password ? {
        ''      => "mcollective",
        default => "${mcollective_stomp_password}",
    }

    $factsource = $mcollective_factsource ? {
        ''      => "yaml",
        default => "${mcollective_factsource}",
    }

# Variables defined also in other Example42 modules
# Here are re-set in order to permit usage of only this mcollective module

    $puppet_classesfile = "/var/lib/puppet/state/classes.txt"

    $nrpe_configdir = $operatingsystem ? {
        debian  => "/etc/nagios/nrpe.d",
        ubuntu  => "/etc/nagios/nrpe.d",
        default => "/etc/nrpe.d",
    }

    $service_hasstatus = $operatingsystem ? {
        debian  => "false",
        ubuntu  => "false",
        default => "true"
    }



## EXTRA INTERNAL VARIABLES

    $packagename_client = $operatingsystem ? {
        default => "mcollective-client",
    }

    $packagename_stomp = $operatingsystem ? {
        debian  => "libstomp-ruby",
        ubuntu  => "libstomp-ruby",
        default => "rubygem-stomp",
    }

    $configfile_client = $operatingsystem ? {
        default => "/etc/mcollective/client.cfg",
    }

    # Libdir. Used in config templates
    $libdir = $operatingsystem ? {
        debian => "/usr/share/mcollective/plugins",
        ubuntu => "/usr/share/mcollective/plugins",
        centos => "/usr/libexec/mcollective",
        redhat => "/usr/libexec/mcollective",
    }



## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        default => "mcollective",
    }

    $servicename = $operatingsystem ? {
        default => "mcollective",
    }

    $processname = $operatingsystem ? {
        default => "mcollectived",
    }

    $hasstatus = $operatingsystem ? {
        default => true,
    }

    $configfile = $operatingsystem ? {
        default => "/etc/mcollective/server.cfg",
    }

    $configfile_mode = $operatingsystem ? {
        default => "640",
    }

    $configfile_owner = $operatingsystem ? {
        default => "root",
    }

    $configfile_group = $operatingsystem ? {
        default => "root",
    }

    $configdir = $operatingsystem ? {
        default => "/etc/mcollective",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/mcollective",
        ubuntu  => "/etc/default/mcollective",
        default => "/etc/sysconfig/mcollective",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        default => "/var/run/mcollectived.pid",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        default => "/var/lib/mcollective",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        default => "/var/log/mcollective.log",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "tcp"
    $port = $stomp_port
    


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) mcollective::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $mcollective_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $mcollective_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$mcollective_monitor_target",
    }

    # BaseUrl to access this host
    $monitor_baseurl_real = $mcollective_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${mcollective_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in mcollective::monitor class
    $monitor_url_pattern = $mcollective_monitor_url_pattern ? {
        ''      => "OK",
        default => "${mcollective_monitor_url_pattern}",
    }

    # If mcollective port monitoring is enabled 
    $monitor_port_enable = $mcollective_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => false,
           default => $monitor_port,
        },
        default => $mcollective_monitor_port,
    }

    # If mcollective url monitoring is enabled 
    $monitor_url_enable = $mcollective_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $mcollective_monitor_url,
    }

    # If mcollective process monitoring is enabled 
    $monitor_process_enable = $mcollective_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $mcollective_monitor_process,
    }

    # If mcollective plugin monitoring is enabled 
    $monitor_plugin_enable = $mcollective_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => false,
           default => $monitor_plugin,
        },
        default => $mcollective_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) mcollective::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $mcollective_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$mcollective_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $mcollective_backup_frequency ? {
        ''      => "daily",
        default => "$mcollective_backup_frequency",
    }

    # If mcollective data have to be backed up
    $backup_data_enable = $mcollective_backup_data ? {
        ''      => $backup_data ? {
           ''      => true,
           default => $backup_data,
        },
        default => $mcollective_backup_data,
    }

    # If mcollective logs have to be backed up
    $backup_log_enable = $mcollective_backup_log ? {
        ''      => $backup_log ? {
           ''      => true,
           default => $backup_log,
        },
        default => $mcollective_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) mcollective::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $mcollective_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$mcollective_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $mcollective_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$mcollective_firewall_destination",
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
