# Class: openntpd::disable
#
# Stops openntpd service and disables it at boot time
#
# Usage:
# include openntpd::disable
#
class openntpd::disable inherits openntpd {
    Service["openntpd"] {
        ensure => "stopped" ,
        enable => "false",
    }
}
