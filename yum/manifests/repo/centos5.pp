class yum::repo::centos5 {

    yum::managed_yumrepo {base:
        descr => 'CentOS-$releasever - Base',
        mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os',
        enabled => 1,
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
        priority => 1,
    }

    yum::managed_yumrepo {updates:
        descr => 'CentOS-$releasever - Updates',
        mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=updates',
        enabled => 1,
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
        priority => 1,
    }

    yum::managed_yumrepo {addons:
        descr => 'CentOS-$releasever - Addons',
        mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=addons',
        enabled => 1,
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
        priority => 1,
    }

    yum::managed_yumrepo {extras:
        descr => 'CentOS-$releasever - Extras',
        mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=extras',
        enabled => 1,
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
        priority => 1,
    }

    yum::managed_yumrepo {centosplus:
        descr => 'CentOS-$releasever - Centosplus',
        mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=centosplus',
        enabled => 1,
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
        priority => 2,
    }

    yum::managed_yumrepo {contrib:
        descr => 'CentOS-$releasever - Contrib',
        mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=contrib',
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
        priority => 10,
    }

}
