# Class: mailscanner::monitor
#
# Monitors mailscanner process and port using custom Monitor wrapper
# It's automatically included if $monitor=yes
#
# Usage:
# include mailscanner::monitor
#
class mailscanner::monitor {

    monitor::process {
        "mailscanner_process":
        name     => $operatingsystem ? {
            default => "MailScanner",
            },
        enable    => true,
    }

}
