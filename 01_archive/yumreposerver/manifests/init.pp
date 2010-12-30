class yumreposerverbase {

    include apache

    package { createrepo:
        name => $operatingsystem ? {
            default    => "createrepo",
            },
        ensure => present,
    }

    package { yum-utils:
        name => $operatingsystem ? {
            default    => "yumutils",
            },
        ensure => present,
    }

    file {
        yumrepo:
            mode => 755, owner => root, group => root,
            ensure => directory,
            path => $operatingsystem ?{
                default => "/var/www/yumrepo",
            },
    }

    file {
        "yumrepo.conf":
            mode => 644, owner => root, group => root,
            ensure => present,
            path => $operatingsystem ?{
                default => "/etc/httpd/conf.d/yumrepo.conf",
            },
            source => "puppet://$servername/yumreposerver/yumrepo.conf",
    }

    file {
        "yumrepo.cron":
            mode => 755, owner => root, group => root,
            ensure => present,
            path => $operatingsystem ?{
                default => "/etc/cron.d/yumrepo.cron",
            },
    }

}

define yumreposerver($description = '') {

    include yumreposerverbase

    $yumrepo_basedir = "/var/www/yumrepo" 

    file {
        [ "$yumrepo_basedir/$name/",
          "$yumrepo_basedir/$name/4",
          "$yumrepo_basedir/$name/4/SRPMS",
          "$yumrepo_basedir/$name/4/i386",
          "$yumrepo_basedir/$name/4/ppc",
          "$yumrepo_basedir/$name/4/x86_64",
          "$yumrepo_basedir/$name/5",
          "$yumrepo_basedir/$name/5/SRPMS",
          "$yumrepo_basedir/$name/5/i386",
          "$yumrepo_basedir/$name/5/ppc",
          "$yumrepo_basedir/$name/5/x86_64" ]:
            mode => 755, owner => root, group => root,
            ensure => directory,
    }

    file {
        [ "$yumrepo_basedir/$name/4AS",
          "$yumrepo_basedir/$name/4ES",
          "$yumrepo_basedir/$name/4WS" ]:
            ensure => "4",
    }

    file {
        [ "$yumrepo_basedir/$name/5Client",
          "$yumrepo_basedir/$name/5Server" ]:
            ensure => "5",
    }

    ensure_line {
        "createrepo_$name":
            file => "/etc/cron.d/yumrepo.cron",
            line => "find /var/www/yumrepo/$name/5 ! \( -name repodata -o -type l  \) -exec createrepo  {} \;",
    }

}
