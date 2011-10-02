class yum::repo::rbel {

    require common

    yum::managed_yumrepo { rbel:
        descr => 'RBEL Repo',
        baseurl => $common::osver ? {
            5 => "http://rbel.frameos.org/stable/el5/$architecture",
            6 => "http://rbel.frameos.org/stable/el6/$architecture",
        },
        enabled => 1,
        gpgcheck => 0,
        failovermethod => 'priority',
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-RBEL' ,
        priority => 16,
    }

}

