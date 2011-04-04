# Class: openssh::example42
#
# Custom class for module openssh on the example42 project. Here you should define all your custom behaviours of the module openssh
# For best reusability (on different projects) place here, whenever possible, all your customizations of this module.
#
# Usage:
# This class doesn't need to be called directly. It's automatically included by class openssh if you have the $my_project varble set as "example42"
#
# Notes: 
# There are basically TWO different ways to "instance" this class:
# class openssh::example42 { } - Without inheritance. Use this method if the class just adds resources ot the ones managed in the main openssh class
# class openssh::example42 inherits openssh { } - WITH inheritance. Use this method if you need to override parameters of resources already defined in the main openssh class.
# The latter method is useful, for example, to provide configuration files according to custom logic.
#
class openssh::example42 inherits openssh {

#    File["sshd_config"] {
#        source => [ 
#            "${openssh::params::openssh_source}/example42/sshd_config-$hostname",
#            "${openssh::params::openssh_source}/example42/sshd_config-$role",
#            "${openssh::params::openssh_source}/example42/sshd_config",
#        ],
#    }

}
