# Class: dovecot::params
#
# Defines dovecot parameters
# In this class are defined as variables values that are used in other dovecot classes
# This class should be included, where necessary, and eventually be enhanced with support for more OS
#
class dovecot::params  {

# Basic settings
    $packagename = $operatingsystem ? {
        debian  => "dovecot-imapd",
        ubuntu  => "dovecot-imapd",
        default => "dovecot",
    }

    $servicename = $operatingsystem ? {
        default => "dovecot",
    }

    $configfile = $operatingsystem ? {
        debian  => "/etc/dovecot/dovecot.conf",
        ubuntu  => "/etc/dovecot/dovecot.conf",
        default => "/etc/dovecot.conf",
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

}
