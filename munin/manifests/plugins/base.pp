class munin::plugins::base {
    file {
    [ '/etc/munin/plugins', '/etc/munin/plugin-conf.d' ]:
#        source => "puppet://$server/modules/common/empty",
        ignore => [ '\.ignore', 'snmp_*' ],
        ensure => directory, checksum => mtime,
#        recurse => true, purge => true, force => true,
        mode => 0755, owner => root, group => 0,
        notify => Service['munin-node'];
    '/etc/munin/plugin-conf.d/munin-node':
        ensure => present,
        mode => 0644, owner => root, group => 0,
        notify => Service['munin-node'],
    }

    munin::plugin {
    [ df, cpu, interrupts, load, memory, netstat, open_files,
        processes, swap, uptime, users, vmstat
    ]:
        ensure => present,
    }
    include munin::plugins::interfaces

    case $kernel {
    openbsd: {
        File['/etc/munin/plugin-conf.d/munin-node']{
        before => File['/var/run/munin'],
        }
    }
    default: {
        File['/etc/munin/plugin-conf.d/munin-node']{
        before => Package['munin-node'],
        }
    }
    }
    case $kernel {
    linux: {
        case $vserver {
        guest: { include munin::plugins::vserver }
        default: {
            include munin::plugins::linux
        }
        }
    }
    }
    case $virtual {
    physical: { include munin::plugins::physical }
    xen0: { include munin::plugins::dom0 }
    }
}
