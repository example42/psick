# Class for managing apt sources
class apt {
    # Aux packages
    package { "debconf-utils": ensure => installed, }

    file {
        # Sources
        "/etc/apt/sources.list":
            owner   => root,
            group   => root,
            mode    => 644;

        # Sources Dir
        "/etc/apt/sources.list.d":
            ensure  => directory,
            mode    => 0755,
            owner   => root,
            group   => 0;

        # Setup apt options
        "/etc/apt/apt.conf":
            owner   => root,
            group   => root,
            mode    => 644;
    }

    exec {
        aptget_update:
            command     => "/usr/bin/apt-get -qq update",
            logoutput   => false,
            refreshonly => true,
            subscribe   => [File["/etc/apt/sources.list"], File["/etc/apt/sources.list.d"], File["/etc/apt/apt.conf"]];
    }
}

