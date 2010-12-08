# Class: zip::params
#
# Defines zip parameters
# In this class are defined as variables values that are used in other zip classes
# This class should be included, where necessary, and eventually be enhanced with support for more OS
#
class zip::params  {

## MODULES INTERNAL VARIABLES
# (Modify only to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        default => "zip",
    }
    $packagenameunzip = $operatingsystem ? {
        default => "unzip",
    }
}
