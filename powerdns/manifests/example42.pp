# Class powerdns::example42
#
# Custom project class for example42 project. Use this to adapt the powerdns module to your project.
# This class is autoloaded if $my_module == example42
#
# You can use your custom project class to modify the standard behaviour of powerdns module
# If you need to override parameters of resources defined in powerdns class use a syntax like
# class powerdns::example42 inherits powerdns {
#     File["powerdns.conf"] {
#         source => [ "puppet:///powerdns/powerdns.conf-$hostname" , "puppet:///powerdns/powerdns.conf" ],
#     }
#
# You don't need to use class inheritance if you don't override or redefine resources in powerdns class
#
# Note that this approach leaves you maximum flexibility on how to manage powerdns application in your environment
# You can add custom resources and decide how to provide the contents of the configuration files:
# - Via static sourced files ( source => ) according to the naming convention you need
# - Via custom templates ( content => ) or templates joins
# - Via some kind on infile line modification tools, such as Augeas or the Example42's conf define approach
#
class powerdns::example42 {

}
