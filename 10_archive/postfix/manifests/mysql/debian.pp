# Class: postfix::mysql::debian
#
# This class installs Postfix with Mysql backend on Debian
#
class postfix::mysql::debian {

    package { postfix-mysql:
        name   => $operatingsystem ? {
            default => "postfix-mysql",
            },
        ensure => $operatingsystem ? {
            debian  => "present",
            ubuntu  => "present",
            default => "absent",
            },
    }

}
