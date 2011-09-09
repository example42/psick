#
# Class: jboss
#
# Installs jboss.
# For a functional installation you need also to define a jboss instance
#
# Usage:
# include jboss
# jboss::instance { "myapp": }
#
class jboss {

    # Load the variables used in this module. Check the params.pp file 
    require jboss::params

    # Installation
    case $jboss::params::use_package {
        yes:     { include jboss::package }
        default: { include jboss::install }
    }

    # Include project specific class if $my_project is set
    if $my_project { include "jboss::${my_project}" }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include jboss::debug }

}
