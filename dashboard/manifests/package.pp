# Class: dashboard::package
#
# Installs DashBoard from package
#
class dashboard::package {

    require puppet::params
    require dashboard::params

    package { dashboard:
        name   => "${dashboard::params::packagename}",
        ensure => present,
    }

}

