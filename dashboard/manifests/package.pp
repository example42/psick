# Class: dashboard::package
#
# Installs DashBoard from package
# You have to provide indipendently the repositories that contain tha package
#
class dashboard::package {

    require puppet::params
    require dashboard::params

    package { dashboard:
        name   => "${dashboard::params::packagename}",
        ensure => present,
    }

}

