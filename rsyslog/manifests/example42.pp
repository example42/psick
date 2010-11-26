# Class rsyslog::example42
#
# Custom project class for example42 project. Use this to adapt the rsyslog module to your project.
# This class is autoloaded if $my_module == example42 and $my_module_onmodule != yes
# If $my_module_onmodule == yes Puppet tries to autoload example42::rsyslog
# that is:  MODULEPATH/example42/manifests/rsyslog.pp
#
# You can use your custom project class to modify the standard behaviour of rsyslog module
# If you need to override parameters of resources defined in rsyslog class use a syntax like
# class rsyslog::example42 inherits rsyslog {
#     File["rsyslog.conf"] {
#         source => [ "puppet:///rsyslog/rsyslog.conf-$hostname" , "puppet:///rsyslog/rsyslog.conf" ],
#     }
#
# You don't need to use class inheritance if you don't override or redefine resources in rsyslog class
#
# Note that this approach leaves you maximum flexinility on how to manage rsyslog application in your environment
# You can add custom resources and decide how to provide the contents of the configuration files:
# - Via static sourced files ( source => ) according to the naming convention you need
# - Via custom templates ( content => ) or templates joins
# - Via some kind on infile line modification tools, such as Augeas or the Example42's conf define approach
#
class rsyslog::example42 {

    # We want the config dir totally clean, except for our customizations
    file { "rsyslog_configdir":
        path    => "${rsyslog::params::configdir}",
        mode    => "755",
        owner   => "${rsyslog::params::configfile_owner}",
        group   => "${rsyslog::params::configfile_group}",
        ensure  => directory,
        recurse => true, purge => true, force => true,
    }

}
