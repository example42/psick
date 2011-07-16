class yum::prerequisites {

    package { "yum-priorities":
        name => $lsbmajdistrelease ? {
            5 => "yum-priorities",
            6 => "yum-plugin-priorities",
            default => "yum-plugin-priorities",
        },
        ensure => present,
    }

    # ensure there are no other repos
    file { "yum_repos_d":
        path => '/etc/yum.repos.d/',
        source => "puppet:///modules/common/empty",
        ensure => directory,
        recurse => true,
        purge => true,
        force => true,
        ignore  => ".svn",
        mode => 0755, owner => root, group => 0;
    }

    #gpg key
    file { "rpm_gpg":
        path => '/etc/pki/rpm-gpg/',
        source => "puppet:///modules/yum/${operatingsystem}.${lsbmajdistrelease}/rpm-gpg/",
        recurse => true,
#        purge => true,
        ignore  => ".svn",
        owner => root,
        group => 0,
        mode => '600',
    }
}
