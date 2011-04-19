# Class rsync::example42
#
# Custom project class for example42 project. Use this to adapt the rsync module to your project.
# This class is autoloaded if $my_module == example42
#
# You can use your custom project class to modify the standard behaviour of rsync module
# If you need to override parameters of resources defined in rsync class use a syntax like
# class rsync::example42 inherits rsync {
#     File["rsync.conf"] {
#         source => [ "puppet:///rsync/rsync.conf-$hostname" , "puppet:///rsync/rsync.conf" ],
#     }
#
# You don't need to use class inheritance if you don't override or redefine resources in rsync class
#
# Note that this approach leaves you maximum flexibility on how to manage rsync application in your environment
# You can add custom resources and decide how to provide the contents of the configuration files:
# - Via static sourced files ( source => ) according to the naming convention you need
# - Via custom templates ( content => ) or templates joins
# - Via some kind on infile line modification tools, such as Augeas or the Example42's conf define approach
#
class rsync::example42 {

}
