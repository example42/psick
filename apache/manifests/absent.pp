# Class: apache::absent
#
# Removes apache package
#
# Usage:
# include apache::absent
#
class apache::absent  {
    package { "apache": 
        ensure => "absent" ,
    }
}
