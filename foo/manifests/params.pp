# Class: foo::params
#
# Sets internal variables and defaults for foo module
# This class is loaded in all the classes that use the values set here 
#
class foo::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
# (The default used is in the line with '')

## Example: Full hostname of foo server
#    $server = $foo_server ? {
#        ''      => "foo",
#        default => "${foo_server}",
#    }


## EXTRA MODULE INTERNAL VARIABLES
#(add here module specific internal variables)



## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        solaris => "CSWfoo",
        debian  => "foo",
        ubuntu  => "foo",
        default => "foo",
    }

    $servicename = $operatingsystem ? {
        debian  => "foo",
        ubuntu  => "foo",
        default => "foo",
    }

    $processname = $operatingsystem ? {
        default => "foo",
    }

    $hasstatus = $operatingsystem ? {
        debian  => false,
        ubuntu  => false,
        default => true,
    }

    $configfile = $operatingsystem ? {
        freebsd => "/usr/local/etc/foo/foo.conf",
        default => "/etc/foo/foo.conf",
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
        default => "/etc/foo",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/foo",
        ubuntu  => "/etc/default/foo",
        default => "/etc/sysconfig/foo",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        default => "/var/run/food.pid",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        default => "/var/lib/foo",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        default => "/var/log/foo",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "tcp"
    $port = "80"
    


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) foo::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $foo_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $foo_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$foo_monitor_target",
    }

    # BaseUrl to access this service
    $monitor_baseurl_real = $foo_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${foo_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in foo::monitor class
    $monitor_url_pattern = $foo_monitor_url_pattern ? {
        ''      => "OK",
        default => "${foo_monitor_url_pattern}",
    }

    # If foo port monitoring is enabled 
    $monitor_port_enable = $foo_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => true,
           default => $monitor_port,
        },
        default => $foo_monitor_port,
    }

    # If foo url monitoring is enabled 
    $monitor_url_enable = $foo_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $foo_monitor_url,
    }

    # If foo process monitoring is enabled 
    $monitor_process_enable = $foo_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $foo_monitor_process,
    }

    # If foo plugin monitoring is enabled 
    $monitor_plugin_enable = $foo_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => false,
           default => $monitor_plugin,
        },
        default => $foo_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) foo::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $foo_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$foo_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $foo_backup_frequency ? {
        ''      => "daily",
        default => "$foo_backup_frequency",
    }

    # If foo data have to be backed up
    $backup_data_enable = $foo_backup_data ? {
        ''      => $backup_data ? {
           ''      => true,
           default => $backup_data,
        },
        default => $foo_backup_data,
    }

    # If foo logs have to be backed up
    $backup_log_enable = $foo_backup_log ? {
        ''      => $backup_log ? {
           ''      => false,
           default => $backup_log,
        },
        default => $foo_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) foo::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $foo_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$foo_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $foo_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$foo_firewall_destination",
    }

    # If firewall filter is enabled
    $firewall_enable = $foo_firewall_enable ? {
        ''      => $firewall_enable ? {
           ''      => true,
           default => $firewall_enable,
        },
        default => $foo_firewall_enable,
    }

}
