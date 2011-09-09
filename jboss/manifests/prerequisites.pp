#
# Class: jboss::prerequisites
#
# Prerequisites for jboss installation
#
class jboss::prerequisites {

    # Unzip is required if you install via sources
    package { "unzip": ensure => present }

# Curl is needed for installation via sources 
# Here is commented since it's already provided by puppi module
#    package { "curl": ensure => present }


}
