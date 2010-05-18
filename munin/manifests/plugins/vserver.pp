class munin::plugins::vserver inherits munin::plugins::base {
    munin::plugin {
        [ netstat, processes ]:
            ensure => present;
    }
}

