# Class activemq::redhat
#
# This class installs the packages needed for the ActiveMQ package provided in 
# http://marionette-collective.org/activemq/

class activemq::redhat {

    package { "java-1.6.0-openjdk":
        ensure => present,
    }

    package { "activemq-info-provider":
        ensure => present,
    }


}

