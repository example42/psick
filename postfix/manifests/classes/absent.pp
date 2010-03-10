# Class: postfix::absent
#
# Removes postfix package
#
# Usage:
# include postfix::absent

class postfix::absent inherits postfix::base {
        Package["postfix"] {
                ensure => "absent" ,
        }
}
