# Class: controltier::client
#
# Manages controltier client installation
# It expectes you have in your repository a package called ctier-client
#
# Usage:
# Automatically included by controltier
#
class controltier::client {

    # Load the variables used in this module. Check the params.pp file
    require controltier::params

    include controltier::client::key

    # Basic Package - Service - Configuration file management
    package { "controltier_client":
        name   => "${controltier::params::packagename}",
        ensure => present,
    }

    exec { "controltier_client_setup":
        command => "su - ${controltier::params::user} -c 'ctl-setup -n $fqdn -s ${controltier::params::server}' ",
        require => File["ctier_sshkey"] ,
        creates => "${controltier::params::root}/ctl/etc/setup.status",
        cwd     => "${controltier::params::root}",
    }

    if $my_project { include "controltier::${my_project}::client" }

}
