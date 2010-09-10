# Class: autofs::monitor
#
# Monitors autofs process and port using custom Monitor wrapper
# It's automatically included if $monitor=yes
#
# Usage:
# include autofs::monitor
#
class autofs::monitor {

    monitor::process {
        "autofs_process":
        name     => $operatingsystem ? {
            default => "automount",
            },
        enable    => true,
    }

}
