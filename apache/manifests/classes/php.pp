# Class: apache::php
#
# Installs Php module for Apache
# Check out php::module and php::pear defines to install specific php modules and pear software
#
# Usage:
# include apache::php
#
class apache::php  {

    include apache 

    package { php:
        name => $operatingsystem ? {
            ubuntu  => "php5",
            debian  => "php5",
            suse    => "php5",
            default => "php",
            },
        ensure => present,
    }

    package { php-common:
        name => $operatingsystem ? {
            ubuntu  => "php5-common",
            debian  => "php5-common",
            suse    => undef,
            default => "php-common",
            },
        ensure => present,
    }
}



# Class: apache::php::pear
#
# Installs Pear for PHP module
#
# Usage:
# include apache::php::pear

class apache::php::pear  {

    include apache::php

    package { php-pear:
        name => $operatingsystem ? {
            default => "php-pear",
            },
        ensure => present,
    }

}

