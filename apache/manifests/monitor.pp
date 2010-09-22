# Class: apache::monitor
#
# Monitors apache process and port using custom Monitor wrapper
# It's automatically included if $monitor=yes
#
# Usage:
# include apache::monitor
#
class apache::monitor {

    monitor::port {
        "apache_port":
        proto   => "tcp",
        port     => 80,
        enable    => true,
    }

    monitor::process {
        "apache_process":
        name     => $operatingsystem ? {
            ubuntu  => "apache2",
            debian  => "apache2",
            default => "httpd",
            },
        enable    => false,
    }

    monitor::plugin {
        "apache_plugin":
        name     => "apache",
        enable    => true,
    }

}
