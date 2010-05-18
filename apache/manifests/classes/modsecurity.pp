# Class: apache::modsecurity
#
# Installs modsecurity  for apache
#
# Usage:
# include apache::modsecurity
#
class apache::modsecurity {

    include apache

    package { mod_security:
        name   => $operatingsystem ? {
            ubuntu  => "mod-security-common",
            debian  => "mod-security-common",
            default => "mod_security",
            },
        ensure => present,
    }
}
