# Class: openntpd::params
#
# Defines openntpd parameters
# In this class are defined as variables values that are used in other openntpd classes
# This class should be included, where necessary, and eventually be enhanced with support for more OS
#
class openntpd::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)

# Define the ntp server(s) to use  
    $server = $ntp_server ? {
        ''      => [ "0.pool.ntp.org" , "1.pool.ntp.org" ],
        default => $ntp_server,
    }

# Define if to sync ntp at boot if clock skwe is more than 180 secs
    $startup = $ntp_startup ? {
        ''      => "no",
        default => $ntp_startup,
    }



## MODULES INTERNAL VARIABLES
# (Modify only to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        default => "openntpd",
    }

    $servicename = $operatingsystem ? {
        default => "openntpd",
    }

    $configfile = $operatingsystem ? {
        default => "/etc/openntpd/ntpd.conf",
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
        debian  => "/etc/default/openntpd",
        ubuntu  => "/etc/default/openntpd",
        redhat  => "/etc/sysconfig/openntpd",
        centos  => "/etc/sysconfig/openntpd",
    }   

## FILE SERVING SOURCE
# Sets the correct source for static files
# In order to provide files from different sources without modifying the module
# you can override the default source path setting the variable $base_source
# Ex: $base_source="puppet://ip.of.fileserver" or $base_source="puppet://$servername/myprojectmodule"
 
# What follows automatically manages the new source standard (with /modules/) from 0.25 

    case $base_source {
        '': { $general_base_source="puppet://$servername" }
        default: { $general_base_source=$base_source }
    }

    $openntpd_source = $puppetversion ? {
        /(^0.25)/ => "$general_base_source/modules/openntpd",
        /(^0.)/   => "$general_base_source/openntpd",
        default   => "$general_base_source/modules/openntpd",
    }

}
