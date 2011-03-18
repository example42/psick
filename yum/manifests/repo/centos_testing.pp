class yum::repo::centos_testing {
    case $yum_centos_testing_include_pkgs {
      '': { fail('Please configure $yum_centos_testing_include_pkgs as we run the testing repo with highest repository') }
    }
    case $yum_centos_testing_exclude_pkgs {
      '': { $yum_centos_testing_exclude_pkgs = 'absent' }
    }
    yum::managed_yumrepo{'centos5-testing':
        descr => 'CentOS-$releasever - Testing',
        baseurl => 'http://dev.centos.org/centos/$releasever/testing/$basearch',
        enabled => 1,
        gpgcheck => 1,
        gpgkey => 'http://dev.centos.org/centos/RPM-GPG-KEY-CentOS-testing',
        priority => 1,
        includepkgs => $yum_centos_testing_include_pkgs,
        exclude => $yum_centos_testing_exclude_pkgs,
    }
}
