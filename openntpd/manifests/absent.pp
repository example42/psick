# Class: openntpd::absent
#
# Removes openntpd package
#
# Usage:
# include openntpd::absent
#
class openntpd::absent inherits openntpd {
    Package["openntpd"] {
        ensure => "absent" ,
    }
}
