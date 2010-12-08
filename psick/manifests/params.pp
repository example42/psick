# Class: psick::params
#
# Sets internal variables and defaults for psick module
# This class is automatically loaded in all the classes that use the values set here 
#
class psick::params  {

   include apache::params

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
# (The default used is in the line with '')

    $workdir = "/var/tmp/psick"
    $confdir = "/etc/psick"
    $user = "www-data"
    $outputdir = $operatingsystem ? {
        debian  => "/var/www/psick",
        ubuntu  => "/var/www/psick",
        suse    => "/srv/www/psick",
        default => "/var/www/html/psick",
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
