# Class: dashboard::package
#
# Installs DashBoard from package
#
class dashboard::package {

    require puppet::params
    require dashboard::params

    file { "puppetlabs.repo":
        path    => $operatingsystem ? {
            /(Debian|Ubuntu)/ => "/etc/apt.sources.d/puppetlabs.conf",
            /(Redhat|CentOS)/ => "/etc/yum.repos.d/puppetlabs.repo",
        },
        mode    => "644",
        owner   => "root",
        group   => "root",
        ensure  => present,
        source  => $operatingsystem ? {
            /(Debian|Ubuntu)/ => "puppet://$servername/dashboard/puppetlabs.apt",
            /(Redhat|CentOS)/ => "puppet://$servername/dashboard/puppetlabs.repo",
        },
    }

    case $operatingsystem {
        ubuntu,debian: {
            exec { "puppetlabs_aptkey":
                command => "gpg --recv-key 8347A27F ; gpg -a --export 8347A27F | sudo apt-key add - ; apt-get update",
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

