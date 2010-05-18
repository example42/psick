class cobbler::example42 inherits cobbler {

# Uncomment and adapt for a separated cobbler data storage mount point
    Package["cobbler"] {
        require => Mount["/var/www/cobbler"],
    }

    file {
        "/var/www/cobbler":
            mode => 755, owner => root, group => root,
            ensure => directory,
    }

    mount {
        "/var/www/cobbler":
            name   => "/var/www/cobbler",
            atboot => true,
            device => "/dev/sdb1",
            ensure => mounted,
            fstype => ext3,
            options => rw,
            require => File["/var/www/cobbler"],
    }


# Custom Source for general configuration files

    File ["/etc/cobbler/settings"] {
            require => Package[cobbler],
            content => template("cobbler/example42/settings"),
    }

    File ["/etc/cobbler/rsync.exclude"] {
            content => template("cobbler/example42/rsync.exclude"),
    }

    File ["/etc/cobbler/dhcp.template"] {
            content => template("cobbler/example42/dhcp.template"),
    }

    file {
        "/etc/cobbler/users.digest":
            mode => 640, owner => root, group => root,
            require => Package[cobbler],
            backup => local,
            ensure => present,
            path => "/etc/cobbler/users.digest",
            source => "puppet://$servername/cobbler/example42/users.digest",
    }


# Kickstart Templates

    file {
        "/etc/cobbler/example42.ks":
            mode => 644, owner => root, group => root,
            require => Package[cobbler],
            backup => local,
            ensure => present,
            content => template("cobbler/example42/example42.ks"),
    }

}
