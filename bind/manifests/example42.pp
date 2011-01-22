# Class bind::example42
#
# Custom project class for example42 project. Use this to adapt the bind module to your project.
# This class is autoloaded if $my_module == example42 and $my_module_onmodule != yes
# If $my_module_onmodule == yes Puppet tries to autoload example42::bind
# that is:  MODULEPATH/example42/manifests/bind.pp
#
# You can use your custom project class to modify the standard behaviour of bind module
# If you need to override parameters of resources defined in bind class use a syntax like
# class bind::example42 inherits bind {
#     File["named.conf"] {
#         source => [ "puppet:///bind/named.conf-$hostname" , "puppet:///bind/named.conf" ],
#     }
#
# You don't need to use class inheritance if you don't override or redefine resources in bind class
#
# Note that this approach leaves you maximum flexinility on how to manage bind application in your environment
# You can add custom resources and decide how to provide the contents of the configuration files:
# - Via static sourced files ( source => ) according to the naming convention you need
# - Via custom templates ( content => ) or templates joins
# - Via some kind on infile line modification tools, such as Augeas or the Example42's conf define approach
#
class bind::example42 {

    # On the DNS master node we manage all the zones 
    # Modify the zone files in MODULES/bind/files/example42/ 

    if ( "$bind::params::servertype" == "master" ) {     
        file { "custom_zones":
            path    => "${bind::params::datadir}",
            mode    => "644" , owner => "root" , group => "root" ,
            require => Package["bind"] , notify  => Service["bind"] ,
            source  => "${bind::params::general_base_source}/bind/example42/master" ,
            recurse => true ,
            ignore  => ".svn",
        }
    }

    if ( "$bind::params::servertype" == "master-dr" ) {
        file { "custom_zones_dr":
            path    => "${bind::params::datadir}",
            mode    => "644" , owner => "root" , group => "root" ,
            require => Package["bind"] , notify  => Service["bind"] ,
            source  => "${bind::params::general_base_source}/bind/example42/master-dr" ,
            recurse => true ,
            ignore  => ".svn",
        }
    }

}
