# Class: dashboard::monitor
#
# Monitors dashboard process and port using custom Monitor wrapper
# It's automatically included if $monitor=yes
#
# Usage:
# include dashboard::monitor
#
class dashboard::monitor {

    monitor::port {
        "dashboard_port_110":
        proto   => "tcp",
        port     => 3000,
        enable    => true,
    }

    monitor::process {
        "dashboard_process":
        name     => $operatingsystem ? {
            default => "dashboard",
            },
        enable    => true,
    }

    monitor::plugin {
        "dashboard_plugin":
        name     => "dashboard",
        enable    => "false",
    }

}
