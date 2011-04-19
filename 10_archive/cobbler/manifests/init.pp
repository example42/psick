class cobbler {
    package { cobbler:
        name => $operatingsystem ? {
            default => "cobbler",
            },
        ensure => present,
    }

    package { syslinux:
        name => $operatingsystem ? {
            default => "syslinux",
            },
        ensure => present,
    }

    service { cobblerd:
        name => $operatingsystem ? {
            default => "cobblerd",
            },
        ensure => running,
        enable => true,
        hasrestart => true,
        require => Package[cobbler],
    }

    file {
        "/etc/cron.daily/cobbler-reposync":
            mode => 755, owner => root, group => root,
            require => Package[cobbler],
            ensure => present,
            source => "puppet://$servername/cobbler/cobbler-reposync",
    }
    file {
        "/etc/cobbler/settings":
            mode => 664, owner => root, group => root,
            require => Package[cobbler],
            ensure => present,
            path => $operatingsystem ?{
                default => "/etc/cobbler/settings",
            },
    }

    file {
        "/etc/cobbler/dhcp.template":
            mode => 644, owner => root, group => root,
            require => Package[cobbler],
            ensure => present,
            path => $operatingsystem ?{
                default => "/etc/cobbler/dhcp.template",
            },
    }

    file {
        "/etc/cobbler/pxedefault.template":
            mode => 644, owner => root, group => root,
            require => Package[cobbler],
            ensure => present,
            path => $operatingsystem ?{
                default => "/etc/cobbler/pxedefault.template",
            },
    }

    file {
        "/etc/cobbler/rsync.exclude":
            mode => 644, owner => root, group => root,
            require => Package[cobbler],
            ensure => present,
            path => $operatingsystem ?{
                default => "/etc/cobbler/rsync.exclude",
            },
    }

}

# Cobbler full server: PXE - DHCP - WEB - SYSLOG
# Requires dhcpd and tfpd modules
# Requires $cobbler_server definition

class cobbler::full inherits cobbler {
    File ["/etc/cobbler/settings"] {
            require => [ Package[cobbler], Package[dhcp], Package[tftp-server]],
            content => template("cobbler/settings-full"),
    }
}
