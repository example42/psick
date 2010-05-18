# Class: dovecot::absent
#
# Removes dovecot package
#
# Usage:
# include dovecot::absent
#
class dovecot::absent inherits dovecot {
    Package["dovecot"] {
        ensure => "absent" ,
    }
}
