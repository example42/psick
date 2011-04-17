# Class foo::example42
#
# Custom project class for example42 project. Use this to adapt the foo module to your project.
# This class is autoloaded if $my_module == example42
#
# You can use your custom project class to modify the standard behaviour of foo module
# If you need to override parameters of resources defined in foo class use a syntax like
# class foo::example42 inherits foo {
#     File["foo.conf"] {
#         source => [ "puppet:///foo/foo.conf-$hostname" , "puppet:///foo/foo.conf" ],
#     }
#
# You don't need to use class inheritance if you don't override or redefine resources in foo class
#
# Note that this approach leaves you maximum flexibility on how to manage foo application in your environment
# You can add custom resources and decide how to provide the contents of the configuration files:
# - Via static sourced files ( source => ) according to the naming convention you need
# - Via custom templates ( content => ) or templates joins
# - Via some kind on infile line modification tools, such as Augeas or the Example42's conf define approach
#
class foo::example42 {

}
