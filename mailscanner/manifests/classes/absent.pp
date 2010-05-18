# Class: mailscanner::absent
#
# Removes mailscanner package
#
# Usage:
# include mailscanner::absent
#
class mailscanner::absent inherits mailscanner {
    Package["mailscanner"] {
        ensure => "absent" ,
    }
}
