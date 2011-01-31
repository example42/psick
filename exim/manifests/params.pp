# Class: exim::params
#
# Defines exim parameters
# In this class are defined as variables values that are used in other exim classes
# This class should be included, where necessary, and eventually be enhanced with support for more OS
#
class exim::params  {


## MODULES INTERNAL VARIABLES
# (Modify only to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        debian  => "exim4",
        ubuntu  => "exim4",
        default => "exim",
    }

    $servicename = $operatingsystem ? {
        debian  => "exim4",
        ubuntu  => "exim4",
        default => "exim",
    }

    # For semplicity and lack of time to deploy a sensibke configuration we cosndier as exim config file on Ubuntu/Debian
    # the debconf file, which is evaluated when the service is started. This file has not the format and the syntax of the official exim file.
    $configfile = $operatingsystem ? {
        debian  => "/etc/exim4/update-exim4.conf.conf",
        ubuntu  => "/etc/exim4/update-exim4.conf.conf",
        default => "/etc/exim/exim.conf",
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

    $exim_source = $puppetversion ? {
        /(^0.25)/ => "$general_base_source/modules/exim",
        /(^0.)/   => "$general_base_source/exim",
        default   => "$general_base_source/modules/exim",
    }

}
