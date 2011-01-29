# Class lighttpd::example42
#
# Custom project class for example42 project. Use this to adapt the lighttpd module to your project.
# This class is autoloaded if $my_module == example42 and $my_module_onmodule != yes
# If $my_module_onmodule == yes Puppet tries to autoload example42::lighttpd
# that is:  MODULEPATH/example42/manifests/lighttpd.pp
#
# You can use your custom project class to modify the standard behaviour of lighttpd module
# If you need to override parameters of resources defined in lighttpd class use a syntax like
# class lighttpd::example42 inherits lighttpd {
#     File["lighttpd.conf"] {
#         source => [ "puppet:///lighttpd/lighttpd.conf-$hostname" , "puppet:///lighttpd/lighttpd.conf" ],
#     }
#
# You don't need to use class inheritance if you don't override or redefine resources in lighttpd class
#
# Note that this approach leaves you maximum flexinility on how to manage lighttpd application in your environment
# You can add custom resources and decide how to provide the contents of the configuration files:
# - Via static sourced files ( source => ) according to the naming convention you need
# - Via custom templates ( content => ) or templates joins
# - Via some kind on infile line modification tools, such as Augeas or the Example42's conf define approach
#
class lighttpd::example42 inherits lighttpd {

    File["lighttpd.conf"] {
        source => [
            "${lighttpd::params::general_base_source}/lighttpd/lighttpd.conf--$hostname",
            "${lighttpd::params::general_base_source}/lighttpd/lighttpd.conf-$role",
            "${lighttpd::params::general_base_source}/lighttpd/lighttpd.conf",
        ],
    }

}
