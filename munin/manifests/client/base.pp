class munin::client::base {
    service { 'munin-node':
    ensure => running, 
    enable => true,
    hasstatus => true,
    hasrestart => true,
    }
    file {'/etc/munin':
    ensure => directory,
    mode => 0755, owner => root, group => 0;
    }
    $real_munin_allow = $munin_allow ? {
    '' => '127.0.0.1',
    default => $munin_allow
    }
    file {'/etc/munin/munin-node.conf':
        content => template("munin/munin-node.conf.$operatingsystem"),
    notify => Service['munin-node'],
        mode => 0644, owner => root, group => 0,
    }
    munin::register { $fqdn: }
    include munin::plugins::base
}
