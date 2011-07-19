define yum::managed_yumrepo (
    $descr = 'absent',
    $baseurl = 'absent',
    $mirrorlist = 'absent',
    $enabled = 0,
    $gpgcheck = 0,
    $gpgkey = 'absent',
    $failovermethod = 'absent',
    $priority = 99,
    $exclude = 'absent',
    $autokeyimport = 'no',
    $includepkgs = 'absent') {

    # ensure that everything is setup
    include yum::prerequisites

    file { "/etc/yum.repos.d/${name}.repo":
        ensure  => file,
        replace => false,
        before  => Yumrepo[$name],
        require => File["yum_repos_d"],
        mode    => 0644, owner => root, group => 0;
    }

    yumrepo { $name:
        descr          => $descr,
        baseurl        => $baseurl,
        mirrorlist     => $mirrorlist,
        enabled        => $enabled,
        gpgcheck       => $gpgcheck,
        gpgkey         => $gpgkey,
        failovermethod => $failovermethod,
        priority       => $priority,
        exclude        => $exclude,
        includepkgs    => $includepkgs,
        require => File["rpm_gpg"],
    }
 
    if $autokeyimport == "yes" and $gpgkey != "" {
        exec { "rpmkey_add_${gpgkey}":
            command => "rpm --import $gpgkey",
            before => Yumrepo["$name"],
            refreshonly => true,
        }
    }
}
