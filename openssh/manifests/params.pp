# Class: openssh::params
#
# Defines openssh parameters
# In this class are defined as variables values that are used in other openssh classes
# This class should be included, where necessary, and eventually be enhanced with support for more OS
#
class openssh::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)


## MODULES INTERNAL VARIABLES
# (Modify only to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        default => "openssh-server",
    }

    $servicename = $operatingsystem ? {
        debian  => "ssh",
        ubuntu  => "ssh",
        redhat  => "sshd",
        centos  => "sshd",
    }

    $configfile = $operatingsystem ? {
        default => "/etc/ssh/sshd_config",
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
        debian  => "/etc/default/ssh",
        ubuntu  => "/etc/default/ssh",
        redhat  => "/etc/sysconfig/sshd",
        centos  => "/etc/sysconfig/sshd",
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

    $openssh_source = $puppetversion ? {
        /(^0.25)/ => "$general_base_source/modules/openssh",
        /(^0.)/   => "$general_base_source/openssh",
        default   => "$general_base_source/modules/openssh",
    }

}
