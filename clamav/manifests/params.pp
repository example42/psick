# Class: clamav::params
#
# Defines clamav parameters
# In this class are defined as variables values that are used in other clamav classes
# This class should be included, where necessary
# Edit and enhance it for support for more OS
#
class clamav::params  {

# Basic settings
    $packagename = $operatingsystem ? {
        default => "clamav",
    }

    $packagename_data = $operatingsystem ? {
        default => "clamav-data",
    }

    $packagename_freshclam = $operatingsystem ? {
        redhat  => "clamav-update",
        centos  => "clamav-update",
        default => "clamav-freshclam",
    }

    $packagename_daemon = $operatingsystem ? {
        redhat  => "clamav-server",
        centos  => "clamav-server",
        default => "clamav-daemon",
    }

    $username = $operatingsystem ? {
        redhat  => "clamd",
        centos  => "clamd",
        default => "clamav",
    }

}
