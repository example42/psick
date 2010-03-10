# Class: dovecot::absent
#
# Removes dovecot package
#
# Usage:
# include dovecot::absent

class dovecot::absent inherits dovecot::base {
        Package["dovecot"] {
                ensure => "absent" ,
        }
}
