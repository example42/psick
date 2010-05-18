class munin::plugins::openbsd inherits munin::plugins::base {
    munin::plugin {
    [ df, cpu, interrupts, load, memory, netstat, open_files,
        processes, swap, users, vmstat
    ]:
        ensure => present,
    }
    munin::plugin {
    [ memory_pools, memory_types ]:
        ensure => present,
    }

}
