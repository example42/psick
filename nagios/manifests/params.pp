# Class: nagios::params
#
# Sets internal variables and defaults for nagios module
# This class is automatically loaded in all the classes that use the values set here 
#
class nagios::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
# (The default used is in the line with '')

    # Hostgroup automatic assignement according to custom logic # TESTING # 
    $hostgroups = $nagios_hostgroups ? {
         ''      => "all",
#         ''      => "$role",
         default => $nagios_hostgroups
    }

    # Define according to what criteria you want to organize what nodes your Nagios servers monitor
    # For example you may want to have different Nagios servers according custom variables as zones, environments, datacenters etc.
    # By default all the checks go to the same server (managed by the same PuppetMaster) if you define in $nagios_grouplogic the name of the variable
    # you want to use as discrimitator, you will have different Nagios servers monitoring the group of nodes having the same value for that variable
    # Note that you need to add in the list below your own variable name, if is not already provided.
    $grouptag = $nagios_grouplogic ? {
         ''            => "",
         'type'        => $type,
         'env'         => $env,
         'environment' => $environment,
         'zone'        => $zone,
         'site'        => $site,
         'role'        => $role,
    }

    # Configure Nagios for External commands support (needed if you want to issue WebCGI commands)
    $check_external_commands = $nagios_check_external_commands ? {
         'yes'   => "yes",
         true    => "yes",
         'true'  => "yes",
         '1'     => "yes",
         default => "no"
    }

# Define if you want to include extra plugins
    $plugins = $nagios_plugins ? {
        ''      => "yes",
        default => "${nagios_plugins}",
    }

    $pluginsdir = $operatingsystem ? {
        /(CentOS|RedHat|Scientific)/ => $architecture ? {
            x86_64  => "/usr/lib64/nagios/plugins",
            default => "/usr/lib/nagios/plugins",
        },
        default => "/usr/lib/nagios/plugins",
    }

# Configure Nagios for using SSL for NRPE Checks
    $use_ssl = $nagios_use_ssl ? {
         'no'    => "no",
         false   => "no",
         'false' => "no",
         default => "yes"
    }

## EXTRA VARIABLES
# The directory where we place automatic Nagios confingurations MUST be fixed
# Cannot be operating system dependent
    $customconfigdir = "/etc/nagios/auto.d"

    # Sets Nagios versions according to default package of different OS. To be updated...
    $version = $operatingsystem ? {
        redhat  => "2",
        centos  => "2",
        debian  => "2",
        default => "3",
    }
    
    $username = $operatingsystem ? {
        default => "nagios",
    } 

    $cachedir = $operatingsystem ? {
        debian  => "/var/cache/nagios2",
        ubuntu  => "/var/cache/nagios3",
        default => "/var/log/nagios",
    }

    $libdir = $operatingsystem ? {
        debian  => "/var/lib/nagios2",
        ubuntu  => "/var/lib/nagios3",
        default => "/var/lib/nagios",
    }

    $resourcefile = $operatingsystem ? {
        debian  => "/etc/nagios2/resource.cfg",
        ubuntu  => "/etc/nagios3/resource.cfg",
        default => "/etc/nagios/private/resource.cfg",
    }

    $statusfile = $operatingsystem ? {
        debian  => "/var/cache/nagios2/status.dat",
        ubuntu  => "/var/cache/nagios3/status.dat",
        default => "/var/log/nagios/status.dat",
    }

    $commanddir = $operatingsystem ? {
        debian  => "/var/lib/nagios2/rw",
        ubuntu  => "/var/lib/nagios3/rw",
        default => "/var/spool/nagios/cmd",
    }

    $commandfile = "${commanddir}/nagios.cmd"

    $resultpath = $operatingsystem ? {
        debian  => "/var/lib/nagios3/spool/checkresults",
        ubuntu  => "/var/lib/nagios3/spool/checkresults",
        default => "/var/spool/nagios/checkresults",
    }

    $retentionfile = $operatingsystem ? {
        debian  => "/var/lib/nagios2/retention.dat",
        ubuntu  => "/var/lib/nagios3/retention.dat",
        default => "/var/log/nagios/retention.dat",
    }

    $p1file = $operatingsystem ? {
        debian  => "/usr/lib/nagios2/p1.pl",
        ubuntu  => "/usr/lib/nagios3/p1.pl",
        default => "/usr/sbin/p1.pl",
    }

    $packagenameplugins = $operatingsystem ? {
        redhat  => "nagios-plugins-all",
        centos  => "nagios-plugins-all",
        default => "nagios-plugins",
    }

    $packagenamenrpeplugin = $operatingsystem ? {
        ubuntu  => "nagios-nrpe-plugin",
        debian  => "nagios-nrpe-plugin",
        default => "nagios-plugins-nrpe",
    }


## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        ubuntu  => "nagios3",
        debian  => "nagios2",
        default => "nagios",
    }

    $servicename = $operatingsystem ? {
        ubuntu  => "nagios3",
        debian  => "nagios2",
        default => "nagios",
    }

    $processname = $operatingsystem ? {
        ubuntu  => "nagios3",
        debian  => "nagios2",
        default => "nagios",
    }

    $hasstatus = $operatingsystem ? {
        default => true,
    }

    $configfile = $operatingsystem ? {
        ubuntu  => "/etc/nagios3/nagios.cfg",
        debian  => "/etc/nagios2/nagios.cfg",
        default => "/etc/nagios/nagios.cfg",
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
        debian  => "/etc/nagios2",
        ubuntu  => "/etc/nagios3",
        default => "/etc/nagios",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/nagios2",
        ubuntu  => "/etc/default/nagios3",
        default => "/etc/sysconfig/nagios",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        debian  => "/var/run/nagios2/nagios2.pid",
        ubuntu  => "/var/run/nagios3/nagios3.pid",
        default => "/var/run/nagios.pid",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        debian  => "/var/lib/nagios2",
        ubuntu  => "/var/lib/nagios3",
        default => "/var/lib/nagios",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        debian  => "/var/log/nagios2",
        ubuntu  => "/var/log/nagios3",
        default => "/var/log/nagios",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "tcp"
    $port = "801"
    


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) nagios::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $nagios_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $nagios_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$nagios_monitor_target",
    }

    # BaseUrl to access this host
    $monitor_baseurl_real = $nagios_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${nagios_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in nagios::monitor class
    $monitor_url_pattern = $nagios_monitor_url_pattern ? {
        ''      => "OK",
        default => "${nagios_monitor_url_pattern}",
    }

    # If nagios port monitoring is enabled 
    $monitor_port_enable = $nagios_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => false,
           default => $monitor_port,
        },
        default => $nagios_monitor_port,
    }

    # If nagios url monitoring is enabled 
    $monitor_url_enable = $nagios_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $nagios_monitor_url,
    }

    # If nagios process monitoring is enabled 
    $monitor_process_enable = $nagios_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $nagios_monitor_process,
    }

    # If nagios plugin monitoring is enabled 
    $monitor_plugin_enable = $nagios_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => false,
           default => $monitor_plugin,
        },
        default => $nagios_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) nagios::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $nagios_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$nagios_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $nagios_backup_frequency ? {
        ''      => "daily",
        default => "$nagios_backup_frequency",
    }

    # If nagios data have to be backed up
    $backup_data_enable = $nagios_backup_data ? {
        ''      => $backup_data ? {
           ''      => true,
           default => $backup_data,
        },
        default => $nagios_backup_data,
    }

    # If nagios logs have to be backed up
    $backup_log_enable = $nagios_backup_log ? {
        ''      => $backup_log ? {
           ''      => false,
           default => $backup_log,
        },
        default => $nagios_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) nagios::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $nagios_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$nagios_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $nagios_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$nagios_firewall_destination",
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
