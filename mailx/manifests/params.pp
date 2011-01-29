# Class: mailx::params
#
# Defines mailx parameters
# In this class are defined as variables values that are used in other mailx classes
# This class should be included, where necessary, and eventually be enhanced with support for more OS
#
class mailx::params  {

## MODULES INTERNAL VARIABLES
# (Modify only to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        ubuntu  => "bsd-mailx",
        default => "mailx",
    }
}
