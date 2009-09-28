class cobbler::example42 inherits cobbler {

        Package["cobbler"] {
                require => Mount["/var/www/cobbler"],
        }

        mount {
                "/var/www/cobbler":
                        name   => "/var/www/cobbler",
                        atboot => true,
                        device => "/dev/xvdb1",
                        ensure => mounted,
                        fstype => ext3,
                        options => rw,
        }


# Custom Source for general configuration files

        File ["/etc/cobbler/settings"] {
                        require => Package[cobbler],
                        source => "puppet://$servername/project_example42/cobbler/settings",
        }

        File ["/etc/cobbler/rsync.exclude"] {
                        source => "puppet://$servername/project_example42/cobbler/rsync.exclude",
        }

        File ["/etc/cobbler/dhcp.template"] {
                        source => "puppet://$servername/project_example42/cobbler/dhcp.template",
        }

        file {
                "/etc/cobbler/users.digest":
                        mode => 640, owner => root, group => root,
                        require => Package[cobbler],
                        ensure => present,
                        path => $os ?{
                                default => "/etc/cobbler/users.digest",
                        },
                        source => "puppet://$servername/project_example42/cobbler/users.digest",
        }


# Kickstart Templates
        file {
                "/etc/cobbler/example42.ks":
                        mode => 644, owner => root, group => root,
                        require => Package[cobbler],
                        ensure => present,
                        source => "puppet://$servername/project_example42/cobbler/example42.ks",
        }


}

