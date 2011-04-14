# Class: lsb::params
#
# Defines lsb parameters
# In this class are defined as variables values that are used in other lsb classes
# This class should be included, where necessary, and eventually be enhanced with support for more OS
#
class lsb::params  {

## MODULES INTERNAL VARIABLES
# (Modify only to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        redhat  => "redhat-lsb",
        centos  => "redhat-lsb",
        scientific => "redhat-lsb",
        default => "lsb",
    }
}
