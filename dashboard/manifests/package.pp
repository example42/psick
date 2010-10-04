# Class: dashboard::package
#
# Installs DashBoard from package
#
class dashboard::package {

    require puppet::params
    require dashboard::params

    file { "puppetlabs.repo":
        path    => $operatingsystem ? {
            /(Debian|debian|Ubuntu|ubuntu)/ => "/etc/apt/sources.list.d/puppetlabs.list",
            /(Redhat|redhat|CentOS|centos)/ => "/etc/yum.repos.d/puppetlabs.repo",
        },
        mode    => "644",
        owner   => "root",
        group   => "root",
        ensure  => present,
        source  => $operatingsystem ? {
            /(Debian|debian|Ubuntu|ubuntu)/ => "${dashboard::params::general_base_source}/dashboard/puppetlabs.apt",
            /(Redhat|redhat|CentOS|centos)/ => "${dashboard::params::general_base_source}/dashboard/puppetlabs.repo",
        },
    }

    case $operatingsystem {
        ubuntu,debian: {
            exec { "puppetlabs_aptkey":
                command => "gpg --recv-key 4BD6EC30 ; gpg -a --export 4BD6EC30 | sudo apt-key add - ; apt-get update",
#                creates => "",
                before  => Package["puppet-dashboard"], 
            }
        }
    }

    package { dashboard:
        name   => "${dashboard::params::packagename}",
        ensure => present,
        require => File["puppetlabs.repo"],
    }

}

