class yum::repo::puppetlabs {

    yum::managed_yumrepo { puppetlabs:
        descr => 'Puppet Labs Packages',
        baseurl => 'http://yum.puppetlabs.com/base/',
        enabled => 1,
        gpgcheck => 1,
        failovermethod => 'priority',
        gpgkey => 'http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs',
        priority => 15,
    }

}
