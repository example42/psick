# Class: mailscanner::disable
#
# Stops mailscanner service and disables it at boot time
#
# Usage:
# include mailscanner::disable
#
class mailscanner::disable inherits mailscanner {
    Service["mailscanner"] {
        ensure => "stopped" ,
        enable => "false",
    }
}
