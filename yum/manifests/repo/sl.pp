class yum::repo::sl {

    yum::managed_yumrepo {"sl6x":
        descr      => 'Scientific Linux 6x - $basearch',
        mirrorlist => 'http://ftp.scientificlinux.org/linux/scientific/mirrorlist/sl-base-6x.txt',
        enabled    => 1,
        gpgcheck   => 1,
        gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-sl file:///etc/pki/rpm-gpg/RPM-GPG-KEY-dawson',
    }

    yum::managed_yumrepo {"sl6x-security":
        descr      => 'Scientific Linux 6x - $basearch - security updates',
        mirrorlist => 'http://ftp.scientificlinux.org/linux/scientific/mirrorlist/sl-security-6x.txt',
        enabled    => 1,
        gpgcheck   => 1,
        gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-sl file:///etc/pki/rpm-gpg/RPM-GPG-KEY-dawson',
    }

    yum::managed_yumrepo {"sl6x-fastbugs":
        descr      => 'Scientific Linux 6x - $basearch - fastbug updates',
        mirrorlist => 'http://ftp.scientificlinux.org/linux/scientific/mirrorlist/sl-fastbugs-6x.txt',
        enabled    => 0,
        gpgcheck   => 1,
        gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-sl file:///etc/pki/rpm-gpg/RPM-GPG-KEY-dawson',
    }

}
