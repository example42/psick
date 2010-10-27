# Class: collectd::absent
#
# Removes collectd package
#
# Usage:
# include collectd::absent
#
class collectd::absent inherits collectd {
    Package["collectd"] {
        ensure => "absent" ,
    }
}
