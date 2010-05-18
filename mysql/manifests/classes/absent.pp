# Class: mysql::absent
#
# Removes mysql package
#
# Usage:
# include mysql::absent
#
class mysql::absent inherits mysql {
    Package["mysql"] {
        ensure => "absent" ,
    }
}
