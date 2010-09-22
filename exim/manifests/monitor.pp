# Class: exim::monitor
#
# Monitors exim process and port using custom Monitor wrapper
# It's automatically included if $monitor=yes
#
# Usage:
# include exim::monitor
#
class exim::monitor {

    monitor::process {
        "exim_process":
        name     => $operatingsystem ? {
            default => "automount",
            },
        enable    => true,
    }

}
