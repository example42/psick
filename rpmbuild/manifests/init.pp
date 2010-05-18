class rpmbuild {
    package { rpm-build:
        name => $operatingsystem ? {
            default    => "rpm-build",
            },
        ensure => "present",
    }

    package { rpm-devel:
        name => $operatingsystem ? {
            default    => "rpm-devel",
            },
        ensure => "present",
    }

    package { rpmlint:
        name => $operatingsystem ? {
            default    => "rpmlint",
            },
        ensure => "present",
    }

    package { "gcc-c++":
        name => $operatingsystem ? {
            default    => "gcc-c++",
            },
        ensure => "present",
    }

    package { make:
        name => $operatingsystem ? {
            default    => "make",
            },
        ensure => "present",
    }
}

class rpmbuild::user inherits rpmbuild  {    

    user {
        "rpmbuilder":
            ensure   => "present",
            uid      => "50101",
            gid      => "50101",
            comment  => "RPM Builder",
            home     => "/home/rpmbuilder",
            require  => Group["rpmbuilder"],
            shell    => "/bin/bash",
    }

    group {
        "rpmbuilder":
            ensure  => "present",
            gid     => "50101"
    }

    file {
        "/home/rpmbuilder/.rpmmacros":
            owner   => "rpmbuilder",
            group   => "rpmbuilder",
            mode    => "640",
            source  => "puppet://$server/rpmbuild/rpmmacros",
    }

    file {
        "/home/rpmbuilder/rpmbuild/SPECS/skel.spec":
            owner   => "rpmbuilder",
            group   => "rpmbuilder",
            mode    => "640",
            source  => "puppet://$server/rpmbuild/skel.spec",
            require => File["/home/rpmbuilder/rpmbuild/SPECS"],
    }

    file {
        "/home/rpmbuilder/rpmbuild":
            owner   => "rpmbuilder",
            group   => "rpmbuilder",
            mode    => "755",
            ensure  => directory,
    }

    file {
        "/home/rpmbuilder/rpmbuild/SRPMS":
            owner   => "rpmbuilder",
            group   => "rpmbuilder",
            mode    => "755",
            ensure  => directory,
    }

    file {
        "/home/rpmbuilder/rpmbuild/SPECS":
            owner   => "rpmbuilder",
            group   => "rpmbuilder",
            mode    => "755",
            ensure  => directory,
    }

    file {
        "/home/rpmbuilder/rpmbuild/BUILD":
            owner   => "rpmbuilder",
            group   => "rpmbuilder",
            mode    => "755",
            ensure  => directory,
    }

    file {
        "/home/rpmbuilder/rpmbuild/SOURCES":
            owner   => "rpmbuilder",
            group   => "rpmbuilder",
            mode    => "755",
            ensure  => directory,
    }

    file {
        "/home/rpmbuilder/rpmbuild/RPMS":
            owner   => "rpmbuilder",
            group   => "rpmbuilder",
            mode    => "755",
            ensure  => directory,
    }

    file {
        "/home/rpmbuilder/rpmbuild/RPMS/x86":
            owner   => "rpmbuilder",
            group   => "rpmbuilder",
            mode    => "755",
            ensure  => directory,
    }

    file {
        "/home/rpmbuilder/rpmbuild/RPMS/noarch":
            owner   => "rpmbuilder",
            group   => "rpmbuilder",
            mode    => "755",
            ensure  => directory,
    }

    file {
        "/home/rpmbuilder/rpmbuild/RPMS/x86_64":
            owner   => "rpmbuilder",
            group   => "rpmbuilder",
            mode    => "755",
            ensure  => directory,
    }

}
