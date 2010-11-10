# Class: puppet::rails
#
# Installs rails package. Need for Puppetmaster with storecongis activated
#
# Usage:
# include puppet::rails
#

class puppet::rails {

    package{ "rails":
        name => $operatingsystem ? {
            default => "rails",
        },
        ensure => installed,
    }

}

