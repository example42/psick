# Class: dashboard::package
#
# Installs DashBoard from package
# You have to provide indipendently the repositories that contain tha package
#
class dashboard::package {

    require puppet::params
    require dashboard::params

    case $operatingsystem {
        debian: { require apt::repo::puppetlabs }
        ubuntu: { require apt::repo::puppetlabs }
        centos: { require yum::repo::puppetlabs }
        redhat: { require yum::repo::puppetlabs }
        default: { }
    }

    package { dashboard:
        name   => "${dashboard::params::packagename}",
        ensure => present,
    }

}

