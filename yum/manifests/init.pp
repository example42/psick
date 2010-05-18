# modules/yum/manifests/init.pp - manage yum
# Copyright (C) 2007 admin@immerda.ch
# GPLv3
# 

# Modified by Lab42

class yum {

    package { 
        yum:
        name => $operatingsystem ? {
            default => "yum",
            },
        ensure => present;

        yum-cron:
        name => $operatingsystem ? {
            default => "yum-cron",
            },
        ensure => present;
    }
    
    service { yum-cron:
        name => $operatingsystem ? {
            default => "yum-cron",
            },
        ensure => $update ?{
            yes     => "running",
            no      => "stopped",
            default => "stopped",
            },
        enable => $update ?{
            yes     => true,
            no      => false,
            default => false,
            },
        hasrestart => true,
        hasstatus => true,
        require => Package[yum-cron],
    }

    file {
        "yum.conf":
            mode => 644, owner => root, group => root,
            require => Package[yum],
            ensure => present,
            path => $operatingsystem ?{
                default => "/etc/yum.conf",
            },
    }



    case $operatingsystem {
    centos: {
        case $lsbdistrelease {
        5: { include yum::centos::five }
        default: { 
            info("No class for this version yet defined, try to configure it with the version for 5")
            include yum::centos::five
        }
        }
    }
    default: { fail("No managed repo yet for this distro") }
    }

}

class yum::centos::five inherits yum {
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
    priority => 10,
    }

    yum::managed_yumrepo {fasttrack:
    descr => 'CentOS-$releasever - Fasttrack',
    mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=fasttrack',
    enabled => 0,
    gpgcheck => 1,
    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
    priority => 10,
    }


    yum::managed_yumrepo { dlutter-rhel5:
    descr => 'Unsupported RHEL5 packages (lutter)',
    baseurl => 'http://people.redhat.com/dlutter/yum/rhel/5/$basearch',
    enabled => 0,
    gpgcheck => 0,
    priority => 15,
    }

    yum::managed_yumrepo { dlutter-source:
    descr => 'Sources for additional test packages (lutter)',
    baseurl => 'http://people.redhat.com/dlutter/yum/SRPMS/',
    enabled => 0,
    gpgcheck => 0,
    priority => 15,
    }
        
    yum::managed_yumrepo { rpmforge-rhel5:
    descr => 'RPMForge RHEL5 packages',
    baseurl => 'http://wftp.tu-chemnitz.de/pub/linux/dag/redhat/el$releasever/en/$basearch/dag',
        enabled => 1,
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-dag',
        priority => 30,
    }
    yum::managed_yumrepo {centos5-atrpms:
        descr => 'CentOS $releasever - $basearch - ATrpms',
    baseurl => 'http://dl.atrpms.net/el$releasever-$basearch/atrpms/stable',
        enabled => 0,
        gpgcheck => 0,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY.atrpms',
        priority => 30,
    }
    
    yum::managed_yumrepo { epel:
        descr => 'Extra Packages for Enterprise Linux $releasever - $basearch',
    mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-$releasever&arch=$basearch',
        enabled => 1,
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
        priority => 16,
    }
    yum::managed_yumrepo { epel-debuginfo:
        descr => 'Extra Packages for Enterprise Linux $releasever - $basearch - Debug',
    mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-$releasever&arch=$basearch',
        enabled => 0,
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
        priority => 16,
    }
    yum::managed_yumrepo { epel-source:
        descr => 'Extra Packages for Enterprise Linux $releasever - $basearch - Source',
    mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-source-$releasever&arch=$basearch',
        enabled => 0,
        gpgcheck => 1,
        failovermethod => priority,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
        priority => 16,
    }
    yum::managed_yumrepo { epel-testing:
        descr => 'Extra Packages for Enterprise Linux $releasever - Testing - $basearch',
    baseurl => 'http://download.fedora.redhat.com/pub/epel/testing/$releasever/$basearch',
        enabled => 0,
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
        priority => 17,
    }
    yum::managed_yumrepo { epel-testing-debuginfo:
        descr => 'Extra Packages for Enterprise Linux $releasever - Testing - $basearch - Debug',
    baseurl => 'http://download.fedora.redhat.com/pub/epel/testing/$releasever/$basearch/debug',
        enabled => 0,
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
        priority => 17,
    }
    yum::managed_yumrepo { epel-testing-source:
        descr => 'Extra Packages for Enterprise Linux $releasever - Testing - $basearch - Source',
    baseurl => 'http://download.fedora.redhat.com/pub/epel/testing/$releasever/SRPMS',
        enabled => 0,
        gpgcheck => 0,
        failovermethod => priority,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
        priority => 17,
    }
    yum::managed_yumrepo { kbs-CentOS-Extras:
        descr => 'CentOS.Karan.Org-EL$releasever - Stable',
    baseurl => 'http://centos.karan.org/el$releasever/extras/stable/$basearch/RPMS/',
        enabled => 0,
        gpgcheck => 0,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-kbsingh',
        priority => 20,
    }
    yum::managed_yumrepo { kbs-CentOS-Misc:
        descr => 'CentOS.Karan.Org-EL$releasever - Stable',
    baseurl => 'http://centos.karan.org/el$releasever/misc/stable/$basearch/RPMS/',
        enabled => 0,
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-kbsingh',
        priority => 20,
    }
    yum::managed_yumrepo { kbs-CentOS-Misc-Testing:
        descr => 'CentOS.Karan.Org-EL$releasever - Testing',
    baseurl => 'http://centos.karan.org/el$releasever/misc/testing/$basearch/RPMS/',
        enabled => 0,
        gpgcheck => 1,
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-kbsingh',
        priority => 20,
    }
}

class yum::prerequisites {
    package{yum-priorities:
    ensure => present,
    } 

    file{yum_repos_d:
    path => '/etc/yum.repos.d/',
    # source => "puppet://$server/yum/empty",
    ensure => directory,
    recurse => true,
    purge => true,
    mode => 0755, owner => root, group => 0;
    }
    #gpg key
    file {rpm_gpg: 
        path => '/etc/pki/rpm-gpg/',
    source => [ "puppet://$server/yum/${operatingsystem}.${lsbdistrelease}/rpm-gpg/",
            "puppet://$server/yum/CentOS.5/rpm-gpg/" ],
        recurse => true,
    purge => true,
        owner => root,
        group => 0,
        mode => '600',
    }
}

define yum::managed_yumrepo (
    $descr = 'absent',
    $baseurl = 'absent', 
    $mirrorlist = 'absent',
    $enabled = 0,
    $gpgcheck = 0,
    $gpgkey = 'absent', 
    $failovermethod = 'absent',
    $priority = 99){

    # ensure that everything is setup
    include yum::prerequisites
    
    file{"/etc/yum.repos.d/${name}.repo":
    ensure => file,
    replace => false,
    before => Yumrepo[$name],
    require => File[yum_repos_d],
    mode => 0644, owner => root, group => 0;
    }

    yumrepo{$name:
    descr => $descr,
    baseurl => $baseurl, 
    mirrorlist => $mirrorlist,
    enabled => $enabled,
    gpgcheck => $gpgcheck,
    gpgkey => $gpgkey, 
    failovermethod => $failovermethod,
    priority => $priority,
    require => [ File[rpm_gpg],
        Package[yum-priorities]
    ],
    }    
}
