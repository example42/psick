class xen {

    package { xen:
        name => $operatingsystem ? {
            default    => "xen",
            },
        ensure => present,
    }

    service { xen:
        name => $operatingsystem ? {
            default => "xend",
            },
        ensure => running,
        enable => true,
        hasrestart => true,
        hasstatus => true,
        require => Package[xen],
    }

    file {    
             "/etc/xen/xend-config.sxp":
            mode => 644, owner => root, group => root,
            require => Package[xen],
            ensure => present,
            path => $operatingsystem ?{
                default => "/etc/xen/xend-config.sxp",
            },
    }

}

class xen::dual inherits xen {

    File["/etc/xen/xend-config.sxp"] {
        source => "puppet://$servername/xen/xend-config.sxp-dual",
    }

    file {    
             "/etc/xen/scripts/network-dual":
            mode => 755, owner => root, group => root,
            require => Package[xen],
            ensure => present,
            path => $operatingsystem ?{
                default => "/etc/xen/scripts/network-dual",
            },
            source => "puppet://$servername/xen/network-dual",
    }
}


class xen::lab42 inherits xen {

}

class xen::lab42::alpha inherits xen::lab42 {

    File["/etc/xen/xend-config.sxp"] {
        source => "puppet://$servername/xen/lab42/xend-config.sxp",
    }

    file {    
             "/etc/xen/scripts/network-lab42":
            mode => 755, owner => root, group => root,
            require => Package[xen],
            ensure => present,
            path => $operatingsystem ?{
                default => "/etc/xen/scripts/network-dual",
            },
            source => "puppet://$servername/xen/lab42/network-lab42",
    }

    file {
        "/etc/xen/start":
            mode => 600, owner => root, group => root,
            require => Package[xen],
            ensure => present,
            source => "puppet://$servername/xen/lab42/start",
    }

    file {
        "/etc/xen/omega":
            mode => 600, owner => root, group => root,
            require => Package[xen],
            ensure => present,
            source => "puppet://$servername/xen/lab42/omega",
    }

    file {
        "/etc/xen/monitor":
            mode => 600, owner => root, group => root,
            require => Package[xen],
            ensure => present,
            source => "puppet://$servername/xen/lab42/monitor",
    }

    file {
        "/etc/xen/live":
            mode => 600, owner => root, group => root,
            require => Package[xen],
            ensure => present,
            source => "puppet://$servername/xen/lab42/live",
    }
}


class xen::lab42::sigma inherits xen::lab42 {

}
