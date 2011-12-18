# Class: apache::ssl
#
class apache::ssl {

    include apache
    require apache::params

    package { "apache-modssl":
        name   => "${apache::params::packagename_modssl}",
        ensure => present,
    }

}
