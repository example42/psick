# Class: mysql::monitor
#
# Monitors mysql process and port using custom Monitor wrapper
# It's automatically included if $monitor=yes
#
# Usage:
# include mysql::monitor
#
class mysql::monitor {

    monitor::process {
        "mysql_process":
        name     => $operatingsystem ? {
            default => "mysqld",
            },
        enable    => true,
    }

}
