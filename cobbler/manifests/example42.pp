class cobbler::example42 inherits cobbler {

# Uncomment and adapt for a separated cobbler data storage mount point
#        Package["cobbler"] {
#                require => Mount["/var/www/cobbler"],
#        }
#
#        mount {
#                "/var/www/cobbler":
#                        name   => "/var/www/cobbler",
#                        atboot => true,
#                        device => "/dev/xvdb1",
#                        ensure => mounted,
#                        fstype => ext3,
#                        options => rw,
#        }


# Custom Source for general configuration files

        File ["/var/lib/cobbler/settings"] {
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
                        path => $os ?{
                                default => "/etc/cobbler/users.digest",
                        },
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
