# Class: dashboard::params
#
# Defines dashboard parameters
# In this class are defined as variables values that are used in other dashboard classes
# This class should be included, where necessary, and eventually be enhanced with support for more OS
#
class dashboard::params  {

# Sets installation method according to user's variable dashboard_install (if not set, default is package)

    $install = $dashboard_install ? {
        source  => "source",
        package => "package",
        default => "package",
    }

# Sets externalnodes support according to user's variable puppet_externalnodes (if not set, default is no)
    $externalnodes = $puppet_externalnodes ? {
        yes  => "yes",
        no   => "no",
        default => "no",
    }

    $basedir = "/usr/share"

# Define dashboard DB type
    $db = $dashboard_db ? {
        sqlite  => "sqlite",
        mysql   => "mysql",
        postgresql   => "postgresql",
        default  => "sqlite",
    }

# Define dashboard DB server ($dashboard_db_server). Default: localhost
    $db_server = $dashboard_db_server ? {
        ''      => "localhost",
        default => $dashboard_db_server,
    }

# Define dashboard DB user ($dashboard_db_user). Default: root
    $db_user = $dashboard_db_user ? {
        ''      => "root",
        default => $dashboard_db_user,
    }

# Define dashboard DB password ($dashboard_db_password). Default: blank
    $db_password = $dashboard_db_password ? {
        ''      => "",
        default => $dashboard_db_password,
    }


# Basic settings
    $packagename = $operatingsystem ? {
        default => "puppet-dashboard",
    }

    $servicename = $operatingsystem ? {
        default => "puppet-dashboard",
    }

    $configfile = $operatingsystem ? {
        default => "/usr/share/puppet-dashboard/config/database.yml",
    }

    $configfilesettings = $operatingsystem ? {
        default => "/usr/share/puppet-dashboard/config/settings.yml",
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

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/dashboardd",
        ubuntu  => "/etc/default/dashboardd",
        default => "/etc/sysconfig/dashboardd",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        default => "/var/run/puppet-dashboard.pid",
    }

    $processname = $operatingsystem ? {
        default => "server",
    }

    $hasstatus = $operatingsystem ? {
        debian  => false,
        ubuntu  => false,
        default => false,
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        default => "/var/lib/dashboard",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        default => "/var/log/dashboard",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "tcp"
    $port = "3000"
    


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) dashboard::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $dashboard_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $dashboard_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$dashboard_monitor_target",
    }

    # BaseUrl to access this host
    $monitor_baseurl_real = $dashboard_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${dashboard_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in dashboard::monitor class
    $monitor_url_pattern = $dashboard_monitor_url_pattern ? {
        ''      => "OK",
        default => "${dashboard_monitor_url_pattern}",
    }

    # If dashboard port monitoring is enabled 
    $monitor_port_enable = $dashboard_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => true,
           default => $monitor_port,
        },
        default => $dashboard_monitor_port,
    }

    # If dashboard url monitoring is enabled 
    $monitor_url_enable = $dashboard_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $dashboard_monitor_url,
    }

    # If dashboard process monitoring is enabled 
    $monitor_process_enable = $dashboard_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $dashboard_monitor_process,
    }

    # If dashboard plugin monitoring is enabled 
    $monitor_plugin_enable = $dashboard_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => false,
           default => $monitor_plugin,
        },
        default => $dashboard_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) dashboard::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $dashboard_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$dashboard_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $dashboard_backup_frequency ? {
        ''      => "daily",
        default => "$dashboard_backup_frequency",
    }

    # If dashboard data have to be backed up
    $backup_data_enable = $dashboard_backup_data ? {
        ''      => $backup_data ? {
           ''      => true,
           default => $backup_data,
        },
        default => $dashboard_backup_data,
    }

    # If dashboard logs have to be backed up
    $backup_log_enable = $dashboard_backup_log ? {
        ''      => $backup_log ? {
           ''      => true,
           default => $backup_log,
        },
        default => $dashboard_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) dashboard::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $dashboard_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$dashboard_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $dashboard_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$dashboard_firewall_destination",
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
