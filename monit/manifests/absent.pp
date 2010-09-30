# Class: monit::absent
#
# Removes monit package
#
# Usage:
# include monit::absent
#
class monit::absent inherits monit {
    Package["monit"] {
        ensure => "absent" ,
    }
}
