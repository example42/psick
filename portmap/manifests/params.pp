# Class: portmap::params
#
# Defines portmap parameters
# In this class are defined as variables values that are used in other portmap classes
# This class should be included, where necessary, and eventually be enhanced with support for more OS
#
class portmap::params  {

## MODULES INTERNAL VARIABLES
# (Modify only to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        default => "portmap",
    }

    $servicename = $operatingsystem ? {
        default => "portmap",
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

    $portmap_source = $puppetversion ? {
        /(^0.25)/ => "$general_base_source/modules/portmap",
        /(^0.)/   => "$general_base_source/portmap",
        default   => "$general_base_source/modules/portmap",
    }

}
