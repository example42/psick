class yum::repo::rpmforge {

    yum::managed_yumrepo { rpmforge-rhel5:
        descr => 'RPMForge RHEL5 packages',
        baseurl => 'http://wftp.tu-chemnitz.de/pub/linux/dag/redhat/el$releasever/en/$basearch/dag',
        enabled => 1,
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-dag',
        priority => 30,
    }

}
