class yum::repo::atrpms {

    yum::managed_yumrepo {centos5-atrpms:
        descr => 'CentOS $releasever - $basearch - ATrpms',
        baseurl => 'http://dl.atrpms.net/el$releasever-$basearch/atrpms/stable',
        enabled => 1,
        gpgcheck => 0,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY.atrpms',
        priority => 30,
    }

}
