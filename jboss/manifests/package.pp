#
# Class: jboss::package
#
# Installs jboss via a package
#
class jboss::package {

    # Load the variables used in this module. Check the params.pp file 
    require jboss::params

    # Basic Package - Service - Configuration file management
    package { "jboss":
        name   => "${jboss::params::packagename}",
        ensure => present,
    }

}
