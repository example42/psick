class yum::prerequisites {

    require yum::params
    require common

    package { "yum-priorities":
        name => $yum::params::packagename_yumpriority ,
        ensure => present,
    }

    # Purge /etc/yum.repos.d contents if yum_clean_repos is true
    file { "yum_repos_d":
        path => '/etc/yum.repos.d/',
        source => "${common::source}/yum/empty",
        ensure => directory,
        recurse => true,
        purge => $yum::params::clean_repos ? {
            true  => true,
            false => false,
        },
        force => true,
        ignore  => ".svn",
        mode => 0755, owner => root, group => 0;
    }

    #gpg key
    file { "rpm_gpg":
        path => '/etc/pki/rpm-gpg/',
        source => "${common::source}/yum/${operatingsystem}.${common::osver}/rpm-gpg/",
        recurse => true,
        # purge => $yum::params::clean_repos ? {
        #     true  => true,
        #     false => false,
        # },
        ignore  => ".svn",
        owner => root,
        group => 0,
        mode => '600',
    }
}
