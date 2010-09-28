# Class: foo::absent
#
# Removes foo package
#
# Usage:
# include foo::absent
#
class foo::absent inherits foo {
    Package["foo"] {
        ensure => "absent" ,
    }
}
