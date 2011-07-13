# Class: vagrant::absent
#
# Removes vagrant package 
#
# Usage:
# include vagrant::absent
#
class vagrant::absent {

    require vagrant::params

    package { "vagrant":
        name   => "${vagrant::params::packagename}",
        ensure => absent,
    }

}
