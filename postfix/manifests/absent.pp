# Class: postfix::absent
#
# Removes postfix package
#
# Usage:
# include postfix::absent
#
class postfix::absent inherits postfix {
    Package["postfix"] {
        ensure => "absent" ,
    }
}
