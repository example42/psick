# Class: bind::params
#
# Sets internal variables and defaults for bind module
# This class is loaded in all the classes that use the values set here 
#
class bind::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
# (The default used is in the line with '')

# Define how you want to manage named.conf:
# "file" - To provide named.conf as a normal template
# "concat" - To build up named.conf using different fragments
#          - This option, set as default, permits the use of the bind::zone define
    $config = $bind_config ? {
        "file"  => "file",
        default => "concat",
    }

# Define what kind of server installation you want
# "master" - Master server. Authoritative for at least a zone.
# "slave" - Slave server. Authoritative for at least a zone.
# "cache" - iChaching only nameserver. Not autoritative
    $servertype = $bind_servertype ? {
        "master"    => "master",
        "master-dr" => "master-dr",
        "slave"     => "slave",
        default     => "cache",
    }

## Define if you want to install bind-chroot packages (only on RedHat/Centos)
    $chroot = $bind_chroot ? {
        true    => "yes",
        "true"  => "yes",
        "yes"   => "yes",
        default => "no",
    }

# Define if you want to log on syslog or custom file ($logdir/bind.log)
    $log = $bind_log ? {
        "syslog" => "syslog",
        default  => "file",
    }

# Define global forwarders
    $forwarders = $bind_forwarders ? {
        ''      => "",
        default => $bind_forwarders,
    }

# Define global slaves to notify (option also-notify)
# (We use _ instead of - since Puppet doesn't like - in variable names
    $also_notify = $bind_also_notify ? {
        ''      => "",
        default => $bind_also_notify,
    }

## EXTRA MODULE INTERNAL VARIABLES
#(add here module specific internal variables)

    $chroot_dir = $chroot ? {
        "yes"   => "/var/named/chroot",
        default => "",   
    } 

    # Used as Base directory in named.conf
    $basedir = $operatingsystem ? {
        centos  => "/var/named",
        redhat  => "/var/named",
        debian  => "/var/cache/bind",
        ubuntu  => "/var/cache/bind",
    }

    # The User running bind
    $user = $operatingsystem ? {
        centos  => "named",
        redhat  => "named",
        debian  => "bind",
        ubuntu  => "bind",
    }

## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        solaris => "CSWbind",
        debian  => "bind9",
        ubuntu  => "bind9",
        default => "bind",
    }

    $servicename = $operatingsystem ? {
        debian  => "bind9",
        ubuntu  => "bind9",
        redhat  => "named",
        centos  => "named",
        default => "bind",
    }

    $processname = $operatingsystem ? {
        default => "named",
    }

    $hasstatus = $operatingsystem ? {
        debian  => false,
        ubuntu  => true,
        default => true,
    }

    $configfile = $operatingsystem ? {
        debian  => "$chroot_dir/etc/bind/named.conf",
        ubuntu  => "$chroot_dir/etc/bind/named.conf",
        default => "$chroot_dir/etc/named.conf",
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
        default => "$chroot_dir/etc/bind",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/bind9",
        ubuntu  => "/etc/default/bind9",
        centos => "/etc/sysconfig/named",
        redhat => "/etc/sysconfig/named",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        centos  => "$chroot_dir/var/run/named.pid",
        redhat  => "$chroot_dir/var/run/named.pid",
        default => "$chroot_dir/var/run/named/named.pid",
    }

    # Used by backup class
    $datadir = "$chroot_dir/$basedir" 

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        default => "$chroot_dir/var/log/named",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "tcp"
    $port = "53"
    


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) bind::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $bind_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $bind_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$bind_monitor_target",
    }

    # BaseUrl to access this service
    $monitor_baseurl_real = $bind_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${bind_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in bind::monitor class
    $monitor_url_pattern = $bind_monitor_url_pattern ? {
        ''      => "OK",
        default => "${bind_monitor_url_pattern}",
    }

    # If bind port monitoring is enabled 
    $monitor_port_enable = $bind_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => true,
           default => $monitor_port,
        },
        default => $bind_monitor_port,
    }

    # If bind url monitoring is enabled 
    $monitor_url_enable = $bind_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $bind_monitor_url,
    }

    # If bind process monitoring is enabled 
    $monitor_process_enable = $bind_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $bind_monitor_process,
    }

    # If bind plugin monitoring is enabled 
    $monitor_plugin_enable = $bind_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => false,
           default => $monitor_plugin,
        },
        default => $bind_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) bind::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $bind_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$bind_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $bind_backup_frequency ? {
        ''      => "daily",
        default => "$bind_backup_frequency",
    }

    # If bind data have to be backed up
    $backup_data_enable = $bind_backup_data ? {
        ''      => $backup_data ? {
           ''      => true,
           default => $backup_data,
        },
        default => $bind_backup_data,
    }

    # If bind logs have to be backed up
    $backup_log_enable = $bind_backup_log ? {
        ''      => $backup_log ? {
           ''      => true,
           default => $backup_log,
        },
        default => $bind_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) bind::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $bind_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$bind_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $bind_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$bind_firewall_destination",
    }

    # If firewall filter is enabled
    $firewall_enable = $bind_firewall_enable ? {
        ''      => $firewall_enable ? {
           ''      => true,
           default => $firewall_enable,
        },
        default => $bind_firewall_enable,
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
