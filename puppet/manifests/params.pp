class puppet::params  {

# Settings that User can define (if not defined, defaults set here apply).
# They are mostly related to PuppetMaster functionality.

# Full hostname of Puppet server
    $server = $puppet_server ? {
        ''      => "puppet",
        default => "$puppet_server",
    }

# Access lists for Puppetmaster access (can be an array)
# You should SET IT 
    $allow = $puppet_allow ? {
        ''      => [ "*.$domain" , "127.0.0.0" ],
        default => $puppet_allow,
    }

# Bind address, useful if only one address should be used or if it should be IPv6
    $bindaddress = $puppet_bindaddress ? {
	''	=> "",
	default => $puppet_bindaddress,
    }

# Use a node tool ($puppet_nodetool). Default: undef
    $nodetool = $puppet_nodetool ? {
        dashboard => "dashboard",
        foreman   => "foreman",
        default   => undef,
    }

# The run interval
    $runinterval = $puppet_runinterval ? {
        "" => "1800",
        default => $puppet_runinterval,
    }

# Use external nodes qualifiers to manage nodes ($puppet_externalnodes). Default: no
# Note that you can still define a $puppet_nodetool and leave $puppet_externalnodes=no
# But if you set $puppet_externalnodes=yes you MUST define a valid $puppet_nodetool
    $externalnodes = $puppet_externalnodes ? {
        yes  => "yes",
        no   => "no",
        default => "no",
    }

# Use passenger (Apache's mod_ruby) instead of default WebBrick ($puppet_passenger). Default: no
    $passenger = $puppet_passenger ? {
        yes  => "yes",
        no   => "no",
        default => "no",
    }

# Use storeconfigs, needed for exported resources ($puppet_storeconfigs). Default: no
    $storeconfigs = $puppet_storeconfigs ? {
        yes  => "yes",
        no   => "no",
        default => "no",
    }

# Use thin storeconfigs, for better performances when using storeconfigs ($puppet_storeconfigs_thin). Default: yes 
    $storeconfigs_thin = $puppet_storeconfigs_thin ? {
        yes  => "yes",
        no   => "no",
        default => "yes",
    }

# Define Puppet DB backend for storeconfigs, needed only if $puppet_storeconfigs=yes ($puppet_db). Default: sqlite
    $db = $puppet_db ? {
        sqlite  => "sqlite",
        mysql   => "mysql",
#        postgresql   => "postgresql", # Not yet supported
        default => "sqlite",
    }

# Define Puppet DB name ($puppet_db_name). Default: puppet
    $db_name = $puppet_db_name ? {
        ''      => "puppet",
        default => "$puppet_db_name",
    }

# Define Puppet DB server ($puppet_db_server). Default: localhost
    $db_server = $puppet_db_server ? {
        ''      => "localhost",
        default => "$puppet_db_server",
    }

# Define Puppet DB user ($puppet_db_user). Default: root
    $db_user = $puppet_db_user ? {
        ''      => "root",
        default => "$puppet_db_user",
    }

# Define Puppet DB password ($puppet_db_password). Default: blank
    $db_password = $puppet_db_password ? {
        ''      => "",
        default => "$puppet_db_password",
    }

# Define the inventory service server (Set "localhost" to use the local puppetmaster)
    $inventoryserver = $puppet_inventoryserver ? {
        ''      => "",
        default => "$puppet_inventoryserver",
    }



# Define Puppet version. Autocalculated: "0.2" for 0.24/0.25 "old" versions, 2.x for new 2.6.x branch.
    $version =  $puppetversion ? {
        /(^0.)/   => "0.2",
        default   => "2.x",
    }




# Module's internal variables
    $packagename = $operatingsystem ? {
        solaris => "CSWpuppet",
        default => "puppet",
    }

    $packagename_server = $operatingsystem ? {
        debian  => "puppetmaster",
        ubuntu  => "puppetmaster",
        default => "puppet-server",
    }

    $servicename = $operatingsystem ? {
        solaris => "puppetd",
        default => "puppet",
    }

    $servicename_server = $operatingsystem ? {
        default => "puppetmaster",
    }

    $processname = $version ? {
            "0.2" => "puppetd",
            "2.x" => "puppet",
    }

    $processname_server = $operatingsystem ? {
        default => "puppetmasterd",
    }

    $hasstatus = $operatingsystem ? {
        debian  => false,
        ubuntu  => false,
        default => true,
    }

    $hasstatus_server = $operatingsystem ? {
        debian  => false,
        ubuntu  => false,
        default => true,
    }

    $configfile = $operatingsystem ? {
        freebsd => "/usr/local/etc/puppet/puppet.conf",
        default => "/etc/puppet/puppet.conf",
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
        freebsd => "/usr/local/etc/puppet/",
        default => "/etc/puppet",
    }

    $basedir = $operatingsystem ? {
        redhat  => "/usr/lib/ruby/site_ruby/1.8/puppet",
        centos  => "/usr/lib/ruby/site_ruby/1.8/puppet",
        default => "/usr/lib/ruby/1.8/puppet",
    }

    $classesfile = $puppetversion ? {
        default => "/var/lib/puppet/state/classes.txt",
    }

    $debugdir = $operatingsystem ? {
        default => "/var/lib/puppet/debug",
    }

    # Used by monitor class
    $pidfile = $operatingsystem ? {
        default => "/var/run/puppet/puppetd.pid",
    }

    $pidfile_server = $operatingsystem ? {
        default => "/var/run/puppet/puppetmasterd.pid",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        default => "/var/lib/puppet",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        debian  => "/var/log/syslog",
        ubuntu  => "/var/log/syslog",
        default => "/var/log/messages",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "tcp"
    $port = "8140"



## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) puppet::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $puppet_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $puppet_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$puppet_monitor_target",
    }

    # BaseUrl to access this host
    $monitor_baseurl_real = $puppet_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${puppet_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in puppet::monitor class
    $monitor_url_pattern = $puppet_monitor_url_pattern ? {
        ''      => "OK",
        default => "${puppet_monitor_url_pattern}",
    }

    # If puppet port monitoring is enabled 
    $monitor_port_enable = $puppet_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => true,
           default => $monitor_port,
        },
        default => $puppet_monitor_port,
    }

    # If puppet url monitoring is enabled 
    $monitor_url_enable = $puppet_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $puppet_monitor_url,
    }

    # If puppet process monitoring is enabled 
    $monitor_process_enable = $puppet_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $puppet_monitor_process,
    }

    # If puppet plugin monitoring is enabled 
    $monitor_plugin_enable = $puppet_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => false,
           default => $monitor_plugin,
        },
        default => $puppet_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) puppet::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $puppet_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$puppet_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $puppet_backup_frequency ? {
        ''      => "daily",
        default => "$puppet_backup_frequency",
    }

    # If puppet data have to be backed up
    $backup_data_enable = $puppet_backup_data ? {
        ''      => $backup_data ? {
           ''      => true,
           default => $backup_data,
        },
        default => $puppet_backup_data,
    }

    # If puppet logs have to be backed up
    $backup_log_enable = $puppet_backup_log ? {
        ''      => $backup_log ? {
           ''      => false,
           default => $backup_log,
        },
        default => $puppet_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) puppet::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $puppet_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$puppet_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $puppet_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$puppet_firewall_destination",
    }

    # If firewall filter is enabled
    $firewall_enable = $puppet_firewall_enable ? {
        ''      => $firewall_enable ? {
           ''      => true,
           default => $firewall_enable,
        },
        default => $puppet_firewall_enable,
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

