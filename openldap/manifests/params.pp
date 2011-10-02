# Class: openldap::params
#
# Sets internal variables and defaults for openldap module
# This class is loaded in all the classes that use the values set here 
#
class openldap::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
# (The default used is in the line with '')

## Base dn
    $base_dn = $openldap_base_dn ? {
        ''      => "dc=example42,dc=com",
        default => "${openldap_base_dn}",
    }

# Root dn
    $root_dn = $openldap_root_dn ? {
        ''      => "cn=Manager,${base_dn}",
        default => "${openldap_root_dn}",
    }

## Admin password (written on conf file as is, so use openldap format)
    $rootpw = $openldap_rootpw ? {
        ''      => '{SSHA}6cOchl1ZhL+N/iuN+MoZ6vFyLcCtw2Ug', # Default password is "example42"
        default => "${openldap_rootpw}",
    }

## Admin password (in cleartext! We'll try to remove this param, currently used in multimaster
# configuration and extra user creation scripts
    $rootpw_clear = $openldap_rootpw_clear ? {
        ''      => 'example42', # Default password is "example42"
        default => "${openldap_rootpw_clear}",
    }


# Use SSL
    $use_ssl = $openldap_use_ssl ? {
        true    => "yes",
        "true"  => "yes",
        "yes"   => "yes",
        default => "no",
    }

# Support Solaris Clients
    $support_solaris_clients = $openldap_support_solaris_clients ? {
        true    => "yes",
        "true"  => "yes",
        "yes"   => "yes",
        default => "no",
    }

# Support Samba schema (to use OpenLdap as Samba backend)
    $support_samba = $openldap_support_samba ? {
        true    => "yes",
        "true"  => "yes",
        "yes"   => "yes",
        default => "no",
    }

# Activate N-WAY multimaster replication
# Requires one or more $openldap_multimaster_masters entries for each server
    $multimaster = $openldap_multimaster ? {
        true    => "yes",
        "true"  => "yes",
        "yes"   => "yes",
        default => "no",
    }

    $multimaster_masters = $openldap_multimaster_masters ? {
        ""      => "",
        default => $openldap_multimaster_masters ,
    }

# Add extra scripts and tools for users management
    $extra = $openldap_extra ? {
        false   => "no",
        "false" => "no",
        "no"    => "no",
        default => "yes",
    }

# User who can manage ldap users via the above tools
    $extra_user = $openldap_extra_user ? {
        ''      => "root",
        default => "$openldap_extra_user",
    }

# Directory where extra scripts are placed
    $extra_dir = $openldap_extra_dir ? {
        ''      => "/root/ldap",
        default => "$openldap_extra_dir",
    }



## EXTRA MODULE INTERNAL VARIABLES
#(add here module specific internal variables)

    # Database backend (only hdb and bdb supported out of the box)
    $db_backend = "hdb"

    $argsfile = $operatingsystem ? {
        debian  => "/var/run/slapd/slapd.args",
        ubuntu  => "/var/run/slapd/slapd.args",
        /(?i:CentOS|RedHat|Scientific)/  => "/var/run/openldap/slapd.args",
    }

    $modulepath = $operatingsystem ? {
        debian  => "/usr/lib/ldap",
        ubuntu  => "/usr/lib/ldap",
        /(?i:CentOS|RedHat|Scientific)/ => $architecture ? {
                       x86_64  => "/usr/lib64/openldap",
                       default => "/usr/lib/openldap",
        },
    }

    $certsdir = $operatingsystem ? {
        debian  => "/etc/ldap/certs",
        ubuntu  => "/etc/ldap/certs",
        /(?i:CentOS|RedHat|Scientific)/ => "/etc/pki/tls/certs",
    }

    # Openldap user
    $username = $operatingsystem ? {
        default => "openldap",
    }

    $packagenameclient = $operatingsystem ? {
        debian  => "ldap-utils",
        ubuntu  => "ldap-utils", 
        /(?i:CentOS|RedHat|Scientific)/ => "openldap-clients",
    }

## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        debian  => "slapd",
        ubuntu  => "slapd",
        /(?i:CentOS|RedHat|Scientific)/ => "openldap-servers",
    }

    $servicename = $operatingsystem ? {
        redhat  => "ldap",
        centos  => "ldap",
        default => "slapd",
    }

    $processname = $operatingsystem ? {
        default => "slapd",
    }

    $hasstatus = $operatingsystem ? {
        debian  => false,
        ubuntu  => true,
        default => true,
    }

    $configfile = $operatingsystem ? {
        /(?i:CentOS|RedHat|Scientific)/ => "/etc/openldap/slapd.conf",
        default => "/etc/ldap/slapd.conf",
    }

    $configfile_mode = $operatingsystem ? {
        default => "640",
    }

    $configfile_owner = $operatingsystem ? {
        default => "root",
    }

    $configfile_group = $operatingsystem ? {
        debian  => "openldap",
        ubuntu  => "openldap",
        /(?i:CentOS|RedHat|Scientific)/ => "ldap",
    }

    $configdir = $operatingsystem ? {
        debian  => "/etc/ldap",
        ubuntu  => "/etc/ldap",
        /(?i:CentOS|RedHat|Scientific)/ => "/etc/openldap",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/slapd",
        ubuntu  => "/etc/default/slapd",
        /(?i:CentOS|RedHat|Scientific)/ => "/etc/sysconfig/lapd",
    }
    
    $pidfile = $operatingsystem ? {
        debian  => "/var/run/slapd/slapd.pid",
        ubuntu  => "/var/run/slapd/slapd.pid",
        /(?i:CentOS|RedHat|Scientific)/ => "/var/run/openldap/slapd.pid",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        default => "/var/lib/ldap",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        default => "/var/log/openldap.log",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "tcp"
    $port = "389"
    


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) openldap::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $openldap_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $openldap_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$openldap_monitor_target",
    }

    # BaseUrl to access this service
    $monitor_baseurl_real = $openldap_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${openldap_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in openldap::monitor class
    $monitor_url_pattern = $openldap_monitor_url_pattern ? {
        ''      => "OK",
        default => "${openldap_monitor_url_pattern}",
    }

    # If openldap port monitoring is enabled 
    $monitor_port_enable = $openldap_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => true,
           default => $monitor_port,
        },
        default => $openldap_monitor_port,
    }

    # If openldap url monitoring is enabled 
    $monitor_url_enable = $openldap_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $openldap_monitor_url,
    }

    # If openldap process monitoring is enabled 
    $monitor_process_enable = $openldap_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $openldap_monitor_process,
    }

    # If openldap plugin monitoring is enabled 
    $monitor_plugin_enable = $openldap_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => false,
           default => $monitor_plugin,
        },
        default => $openldap_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) openldap::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $openldap_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$openldap_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $openldap_backup_frequency ? {
        ''      => "daily",
        default => "$openldap_backup_frequency",
    }

    # If openldap data have to be backed up
    $backup_data_enable = $openldap_backup_data ? {
        ''      => $backup_data ? {
           ''      => true,
           default => $backup_data,
        },
        default => $openldap_backup_data,
    }

    # If openldap logs have to be backed up
    $backup_log_enable = $openldap_backup_log ? {
        ''      => $backup_log ? {
           ''      => false,
           default => $backup_log,
        },
        default => $openldap_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) openldap::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $openldap_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$openldap_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $openldap_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$openldap_firewall_destination",
    }

    # If firewall filter is enabled
    $firewall_enable = $openldap_firewall_enable ? {
        ''      => $firewall_enable ? {
           ''      => true,
           default => $firewall_enable,
        },
        default => $openldap_firewall_enable,
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
