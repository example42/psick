# Class: puppet::rails
#
# Installs rails package. Need for Puppetmaster with storeconfigs activated
# Some tweaks to make it work on default Debian 5 - Ubuntu LTS - Centos/RedHat 5
#
# Usage:
# include puppet::rails
#

class puppet::rails {

    package{ "rails":
        name => $operatingsystem ? {
            default => "rails",
        },
        ensure => $operatingsystem ? {
            centos  => "2.3.5",
            redhat  => "2.3.5",
            default => "installed",
        },
        provider => $operatingsystem ? {
            debian  => "apt",
            ubuntu  => "apt",
            default => "gem",
        },
    }

}

