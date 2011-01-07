# Class: php
#
# Installs Php 
#
# Usage:
# include php
#
class php  {

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

    package { php-cli:
        name => $operatingsystem ? {
            ubuntu  => "php5-cli",
            debian  => "php5-cli",
            suse    => undef,
            default => "php-cli",
            },
        ensure => present,
    }


}

