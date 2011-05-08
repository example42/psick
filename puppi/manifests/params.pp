# Class: puppi::params
#
# Sets internal variables and defaults for puppi module
# This class is automatically loaded in all the classes that use the values set here 
#
class puppi::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
    $extra = $puppi_extra ? {
        ''      => "no",
        default => "${puppi_extra}",
    }

## INTERNALVARS

    $basedir = "/etc/puppi"
    $scriptsdir = "/etc/puppi/scripts"
    $checksdir = "/etc/puppi/checks"
    $logsdir = "/etc/puppi/logs"
    $infodir = "/etc/puppi/info"
    $tododir = "/etc/puppi/todo"
    $projectsdir = "/etc/puppi/projects"
    $workdir = "/tmp/puppi"
    $libdir = "/var/lib/puppi"
    $archivedir = "/var/lib/puppi/archive"
    $readmedir = "/var/lib/puppi/readme"
    $logdir = "/var/log/puppi"

    $configfile_mode = $operatingsystem ? {
        default => "644",
    }

    $configfile_owner = $operatingsystem ? {
        default => "root",
    }

    $configfile_group = $operatingsystem ? {
        default => "root",
    }

# External tools
    $nrpepluginsdir = $operatingsystem ? {
        /(CentOS|RedHat|centos|redhat)/ => $architecture ? {
            x86_64  => "/usr/lib64/nagios/plugins",
            default => "/usr/lib/nagios/plugins",
        },
        default => "/usr/lib/nagios/plugins",
    }

    $ntp_server = $ntp_server ? {
        ''      => "pool.ntp.org" ,
        default => $ntp_server ,
    }

# Commands used in puppi info templates

    $info_package_query = $operatingsystem ? {
        /(CentOS|RedHat|centos|redhat)/ => "rpm -qi",
        /(Ubuntu|Debian|ubuntu|debian)/ => "dpkg -s",
        default => "echo",
    }

    $info_package_list = $operatingsystem ? {
        /(CentOS|RedHat|centos|redhat)/ => "rpm -ql",
        /(Ubuntu|Debian|ubuntu|debian)/ => "dpkg -L",
        default => "echo",
    }

    $info_service_check = $operatingsystem ? {
        default => "/etc/init.d/",
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
