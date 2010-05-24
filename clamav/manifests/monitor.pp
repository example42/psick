# Class: clamav::monitor
#
# Monitors clamav process and port using custom Monitor wrapper
# It's automatically included if $monitor=yes
#
# Usage:
# include clamav::monitor
#
class clamav::monitor {

    monitor::process {
        "clamav_process":
        name     => $operatingsystem ? {
            default => "clamd",
            },
        enable    => true,
    }

}
