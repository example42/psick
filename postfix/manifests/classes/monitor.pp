# Class: postfix::monitor
#
# Monitors postfix process and port using custom Monitor wrapper
# It's automatically included if $monitor=yes
#
# Usage:
# include postfix::monitor
#
class postfix::monitor {

    monitor::port {
        "postfix_port":
        proto   => "tcp",
        port     => 25,
        enable    => true,
    }

    monitor::process {
        "postfix_process":
        name     => $operatingsystem ? {
            default => "master",
            },
        enable    => true,
    }

    monitor::plugin {
        "postfix_plugin":
        name     => "postfix",
        enable    => "false",
    }

}
