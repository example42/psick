# Class: puppet::monitor
#
# Monitors puppet process and port using custom Monitor wrapper
# It's automatically included if $monitor=yes
#
# Usage:
# include puppet::monitor
#
class puppet::monitor {

    monitor::port {
        "puppet_port":
        proto   => "tcp",
        port     => 8140,
        enable    => false,
    }

    monitor::process {
        "puppet_process":
        name     => $operatingsystem ? {
            default => "puppet",
            },
        enable    => true,
    }

    monitor::plugin {
        "puppet_plugin":
        name     => "puppet",
        enable    => "false",
    }

}
